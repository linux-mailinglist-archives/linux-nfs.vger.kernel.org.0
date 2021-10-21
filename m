Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B019436478
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Oct 2021 16:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhJUOkZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Oct 2021 10:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbhJUOkY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Oct 2021 10:40:24 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F66C0613B9
        for <linux-nfs@vger.kernel.org>; Thu, 21 Oct 2021 07:38:08 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 439D96EB2; Thu, 21 Oct 2021 10:38:08 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 439D96EB2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1634827088;
        bh=/BlsD1gn29gCvSKq9x0SYSGgGj3MZe198VmEE/Bp27U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y7Ak4NENovGHrQHSC7/5wpUQDVtgkwvvORs0gVfOhhAr+vVg+HW2oV9/LVbh3az3i
         zUpd4fmmMGZS7juE3la2uyUNVutV0b/oIopzZ4ObiwRfXcftCoJmuJgLwuug6WLaCx
         SEUzfUlXb+ZnWkD/8el4I94yprWUuvfF521v9fwo=
Date:   Thu, 21 Oct 2021 10:38:08 -0400
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "schumakeranna@gmail.com" <schumakeranna@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "dai.ngo@oracle.com" <dai.ngo@oracle.com>,
        "steved@redhat.com" <steved@redhat.com>,
        "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: server-to-server copy by default
Message-ID: <20211021143808.GD25711@fieldses.org>
References: <20211020155421.GC597@fieldses.org>
 <CAN-5tyHuq3wmU1EThrfqv7Mq+F5o0BXXdkAnGXch_sYakv=eqA@mail.gmail.com>
 <0492823C-5F90-494E-8770-D0EC14130846@oracle.com>
 <20211020181512.GE597@fieldses.org>
 <EC5F0B99-7866-4AA6-BF2F-AB1A93C623DF@oracle.com>
 <20211021141329.GC25711@fieldses.org>
 <aec219339d8296b7e9b114d9d247a71fd47423c5.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aec219339d8296b7e9b114d9d247a71fd47423c5.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Oct 21, 2021 at 02:22:13PM +0000, Trond Myklebust wrote:
> Yes, that's mostly fixed. As far as I'm concerned, there should be no
> major obstacles to allowing unprivileged mounts in their own private
> net namespace.

Do you think it'd be a reasonable thing to turn on now by default in
distros or something the admin should have to opt-in to only on trusted
networks?

I'm wondering how much confidence we have in the client's robustness in
the face of possibly compromised servers.

> The one thing to note, though, is that AUTH_SYS still required that the
> container be given a CAP_NET_BIND_SERVICE privilege to allow binding to
> a privileged port.

Got it, thanks.

--b.
