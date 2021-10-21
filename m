Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993374363D8
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Oct 2021 16:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhJUOPt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Oct 2021 10:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbhJUOPs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Oct 2021 10:15:48 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8814C0613B9
        for <linux-nfs@vger.kernel.org>; Thu, 21 Oct 2021 07:13:30 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id A0706647C; Thu, 21 Oct 2021 10:13:29 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org A0706647C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1634825609;
        bh=I6DamTb7z8zUL9FhNKT6FNdQlEhtr8K2DNirFTT4rUs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OljQVyeA0yvAW6+0F8Qz0mrnOMv0eK2yqmQ5HXhz24axOuxoyuXQVciu1vK0EKp7t
         ih/gWheQpjyOxjNKEtyuMlBweqUG5iClz+SwcCjFSDPgumtgZyxPc5/wg+7DvSNbH2
         a8o7M84iEBxZVn5ddAUp+dxnmbK+tNrpE5YBGOvg=
Date:   Thu, 21 Oct 2021 10:13:29 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Dai Ngo <dai.ngo@oracle.com>, Steve Dickson <steved@redhat.com>
Subject: Re: server-to-server copy by default
Message-ID: <20211021141329.GC25711@fieldses.org>
References: <20211020155421.GC597@fieldses.org>
 <CAN-5tyHuq3wmU1EThrfqv7Mq+F5o0BXXdkAnGXch_sYakv=eqA@mail.gmail.com>
 <0492823C-5F90-494E-8770-D0EC14130846@oracle.com>
 <20211020181512.GE597@fieldses.org>
 <EC5F0B99-7866-4AA6-BF2F-AB1A93C623DF@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EC5F0B99-7866-4AA6-BF2F-AB1A93C623DF@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 20, 2021 at 07:04:53PM +0000, Chuck Lever III wrote:
> Unprivileged mounting seems like a different question to me.
> Related, possibly, but not the same. I'd rather leave that
> discussion to another thread.

Well, I'd be curious if client maintainers have any thoughts.

The NFS client still disallows unprivileged mounts, right?  Is it
something you think could be supported, and if so, do you have an idea
what's left to do?

Trond, I remember asking you about unprivileged mounts at a bakeathon a
few years ago, and at the time you seemed to think it'd be a reasonable
thing to do eventually, and the one obstacle you mentioned was that the
client wasn't capable of maintaining separate state in different
namespaces.  That's fixed, isn't it?

--b.
