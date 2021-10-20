Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDC743527B
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Oct 2021 20:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhJTSR2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Oct 2021 14:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbhJTSR2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Oct 2021 14:17:28 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F392C06161C
        for <linux-nfs@vger.kernel.org>; Wed, 20 Oct 2021 11:15:13 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id D47D36EA9; Wed, 20 Oct 2021 14:15:12 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org D47D36EA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1634753712;
        bh=Ob3ZCk1Glc+x45Nn4JRt3pj0apyRpTy0N1MVfLodAyY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vA8hHcdXQzoFrUSD3lp3AxvyBKJcFL5hVJn5lk4m67aoKkCUvVInS5cEU0bBoPshK
         0Tg7QeJrqREFfSLyncNzQ43i4JSLrR8NYoKOXp1qnWX7MmaDJyBCxIyxX5kCyztjBx
         efZZ/qvEmvuq5nEIRafcvMpPX5fZ6+o39RPO0o+k=
Date:   Wed, 20 Oct 2021 14:15:12 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Dai Ngo <dai.ngo@oracle.com>, Steve Dickson <steved@redhat.com>
Subject: Re: server-to-server copy by default
Message-ID: <20211020181512.GE597@fieldses.org>
References: <20211020155421.GC597@fieldses.org>
 <CAN-5tyHuq3wmU1EThrfqv7Mq+F5o0BXXdkAnGXch_sYakv=eqA@mail.gmail.com>
 <0492823C-5F90-494E-8770-D0EC14130846@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0492823C-5F90-494E-8770-D0EC14130846@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 20, 2021 at 05:45:58PM +0000, Chuck Lever III wrote:
> > On Oct 20, 2021, at 12:37 PM, Olga Kornievskaia <olga.kornievskaia@gmail.com> wrote:
> > 
> > On Wed, Oct 20, 2021 at 11:54 AM J. Bruce Fields <bfields@fieldses.org> wrote:
> >> 
> >> knfsd has supported server-to-server copy for a couple years (since
> >> 5.5).  You have set a module parameter to enable it.  I'm getting asked
> >> when we could turn that parameter on by default.
> >> 
> >> I've got a couple vague criteria: one just general maturity, the other a
> >> security question:
> >> 
> >> 1. General maturity: the only reports I recall seeing are from testers.
> >> Is anyone using this?  Does it work for them?  Do they find a benefit?
> >> Maybe we could turn it on by default in one distro (Fedora?) and promote
> >> it a little and see what that turns up?
> >> 
> >> 2. Security question: with server-to-server copy enabled, you can send
> >> the server a COPY call with any random address, and the server will
> >> mount that address, open a file, and read from it.  Is that safe?
> > 
> > How about adding a piece then on the server (a policy) that would only
> > control that? The concept behind the server-to-server was that servers
> > might have a private/fast network between them that they would want to
> > utilize. A more restrictive policy could be to only allow predefined
> > network space to do the COPY? I know that more work. But sound like
> > perhaps it might be something that provides more control to the
> > server.
> > 
> > But as Chuck pointed out perhaps the kerberos piece would make this
> > concern irrelevant.
> 
> I like the idea of having a server-side policy setting that
> controls whether s2sc is permitted, and maybe establishes a
> range of IP addresses allowed to be destination servers.

Maybe, but:

	1) Couldn't you get something awfully close to that with
	firewall configuration?

	2) I'm getting asked why server-side copy isn't on by default.
	So I guess the requirement to set inter_copy_offload_enable is
	too much.  How does requiring more complicated configuration
	answer that concern?

	3) There's interest in allowing unprivileged NFS mounts.  That's
	more of a security risk than this.  What's the client
	maintainers' judgement about unprivileged NFS mounts?  Do they
	think that would be safe to allow by default in distros?  If so,
	then we're certainly fine here.

--b.
