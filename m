Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A84B30E3D9
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Feb 2021 21:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhBCUIm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Feb 2021 15:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbhBCUIh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Feb 2021 15:08:37 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BC3C061573
        for <linux-nfs@vger.kernel.org>; Wed,  3 Feb 2021 12:07:57 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 246DC6EB8; Wed,  3 Feb 2021 15:07:56 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 246DC6EB8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1612382876;
        bh=pu2VPU3aIAT0BtDQJatlzHnNI8ERYChbCeLzIXlk06Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a46SGtasuaRMRN0w3UzmA6Lv/H2/Es82OQeG0DcJqbuP56FACQfK+5V2r/icpt4aZ
         kTlmNgEXgmQrpbcUJVupcOC/Sb22FsHJeI4VVZtRrGaXoAPehaQvwB90WbnZn6Zlgi
         TUNYM+OHpqH1R2H8diT/OWqqHopsbmC4pwZBK80A=
Date:   Wed, 3 Feb 2021 15:07:56 -0500
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "guy@vastdata.com" <guy@vastdata.com>,
        "schumakeranna@gmail.com" <schumakeranna@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfs: we don't support removing system.nfs4_acl
Message-ID: <20210203200756.GA30996@fieldses.org>
References: <20210128223638.GE29887@fieldses.org>
 <95e5f9e4-76d4-08c4-ece3-35a10c06073b@vastdata.com>
 <cbc7115cc5d5aeb7ffb9e9b3880e453bf54ecbdb.camel@hammerspace.com>
 <20210129023527.GA11864@fieldses.org>
 <20210129025041.GA12151@fieldses.org>
 <7a078b4d22c8d769a42a0c2b47fd501479e47a7b.camel@hammerspace.com>
 <20210131215843.GA9273@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210131215843.GA9273@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Jan 31, 2021 at 04:58:43PM -0500, bfields@fieldses.org wrote:
> On Sun, Jan 31, 2021 at 08:41:37PM +0000, Trond Myklebust wrote:
> > On Thu, 2021-01-28 at 21:50 -0500, bfields@fieldses.org wrote:
> > > On Thu, Jan 28, 2021 at 09:35:27PM -0500, bfields@fieldses.org wrote:
> > > > Note that this patch doesn't prevent an application from setting a
> > > > zero-length ACL.  The xattr format is XDR with the first four bytes
> > > > representing the number of ACEs, so you'd set a zero-length ACL by
> > > > passing down a 4-byte all-zero buffer as the new value of the
> > > > system.nfs4_acl xattr.
> > > > 
> > > > A zero-length NULL buffer is what's used to implement removexattr:
> > > > 
> > > > int
> > > > __vfs_removexattr(struct dentry *dentry, const char *name)
> > > > {
> > > >         ...
> > > >         return handler->set(handler, dentry, inode, name, NULL, 0,
> > > > XATTR_REPLACE);
> > > > }
> > > > 
> > > > That's the case this patch covers.
> > > 
> > > So, I should have said in the changelog, apologies--the behavior
> > > without
> > > this patch is that when it gets a removexattr, the client sends a
> > > SETATTR with a bitmap claiming there's an ACL attribute, but a
> > > zero-length attribute value list, and the server (correctly) returns
> > > BADXDR.
> > > 
> > 
> > I don't see anything in the spec that prohibits a zero length array
> > size for nfs41_aces<> or states that should return NFS4ERR_BADXDR. Why
> > shouldn't we allow that?
> 
> Again: I agree.  And we do allow that, both before and after this patch.
> 
> There's a difference between a SETATTR with a zero-length body and a
> SETATTR with a body containing a zero-length ACL.  The former is bad
> protocol, the latter is, I agree, fine.

Are we on the same page now?  Or should I update the changelog and
resend?

--b.
