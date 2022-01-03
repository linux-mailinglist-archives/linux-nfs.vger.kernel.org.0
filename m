Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A2F4838A9
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jan 2022 22:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiACV6z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jan 2022 16:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiACV6y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Jan 2022 16:58:54 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C73C061761
        for <linux-nfs@vger.kernel.org>; Mon,  3 Jan 2022 13:58:54 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id D4ECA4C7F; Mon,  3 Jan 2022 16:58:53 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org D4ECA4C7F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1641247133;
        bh=I+Umfev4aM0XGYfAIB67V/uqjWmLEBVj5N0qYz03wM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OBarsfZAwedeFJgQ8kbWswC4GBaTgaC4YdImrTgfTtLbuA8RQuB7I2v6TIlrrR6m2
         D6nMHiUcXDMYp3hNxm6XN5ReB0E7E5taUyi9GK08HEC11tE1FVfn9Pkv4N8/PY4qzN
         qJVW+XNbfnBMzIKuCtNq2W1UvEtG5nmjNwoUwMzg=
Date:   Mon, 3 Jan 2022 16:58:53 -0500
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "lists@doriantaylor.com" <lists@doriantaylor.com>
Subject: Re: GSSAPI as it relates to NFS
Message-ID: <20220103215853.GP21514@fieldses.org>
References: <234CDB6C-C565-4BB4-AE38-92F4B05AB4BD@doriantaylor.com>
 <48DBBF53-7CE3-4DDA-B697-B14F8C382E78@oracle.com>
 <AF7243DE-250E-4CCB-86C0-40C69BB71C88@doriantaylor.com>
 <9DA49FE9-F4AF-44CC-8BCF-86F4D2D984AA@oracle.com>
 <20220103213229.GL21514@fieldses.org>
 <1a7193c740c8cb7ba94ecfb5d5eedd32af37088c.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a7193c740c8cb7ba94ecfb5d5eedd32af37088c.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jan 03, 2022 at 09:45:45PM +0000, Trond Myklebust wrote:
> On Mon, 2022-01-03 at 16:32 -0500, J. Bruce Fields wrote:
> > On Sat, Dec 25, 2021 at 10:53:33PM +0000, Chuck Lever III wrote:
> > > IIRC Linux requires that a mount operation be done by root. If you
> > > run
> > > gssd with "-n", become root, then kinit as yourself, I think it
> > > should
> > > work.
> > > 
> > > There has been some discussion about enabling a non-privileged user
> > > to
> > > perform a mount... it's a bit tricky because the function of mount
> > > is
> > > to alter the file namespace, which traditionally requires extra
> > > privilege to do.
> > 
> > The core VFS code is quite happy to allow you to make unprivileged
> > mounts in your own namespace, but the particular filesystem being
> > mounted also gets a veto.
> > 
> > I think we're expecting NFS will be patched to allow unprivileged
> > mounts
> > some time.  See e.g.
> > 
> >         
> > https://lore.kernel.org/linux-nfs/aec219339d8296b7e9b114d9d247a71fd47423c5.camel@hammerspace.com
> > /
> > 
> > --b.
> 
> As noted, the main issue is the bind() privileges needed for AUTH_SYS. 
> 
> When using AUTH_GSS, the knfsd server doesn't care about the
> originating port, which would allow unprivileged mounts to go ahead
> provided that the user specifies the 'noresvport' mount option on the
> client. Isn't that working?

Oh, I remembered you'd said that was one of the issues, but didn't
understand that that was literally the only check remaining in the
code....  In which case, you could also test this by using setcap on
/usr/bin/mount or capsh to give the mount process CAP_NET_BIND_SERVICE?
(If you also set up the right namespaces first.)

--b.
