Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0E22501EC
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Aug 2020 18:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgHXQ0D (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Aug 2020 12:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgHXQ0C (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Aug 2020 12:26:02 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD90AC061573
        for <linux-nfs@vger.kernel.org>; Mon, 24 Aug 2020 09:26:01 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 6F949448D; Mon, 24 Aug 2020 12:26:00 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 6F949448D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1598286360;
        bh=Oq1kHB2pHTillv8DlzXhdgqzxtnklDLaMGBpIaOrtiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mNVebHAMUNNfWigBC213oyP73Hlw0YzerhW6q7jNM3IVW397VkypoYcTR2LWtF0sL
         zke/EUM/CVmRONLZHc1XEdazg4Se0LNzD2SPdW8dFltxz48W7Ic4mDOuInZSmC6vno
         WstR+KYN4dq+6AQOV0bWVtlExYiIWjCvSphOpBWk=
Date:   Mon, 24 Aug 2020 12:26:00 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chucklever@gmail.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: remove fault injection code
Message-ID: <20200824162600.GA29927@fieldses.org>
References: <20200820194944.GC28555@fieldses.org>
 <6895C9AD-3622-4925-A268-23E6404C42D1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6895C9AD-3622-4925-A268-23E6404C42D1@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Aug 24, 2020 at 09:53:37AM -0400, Chuck Lever wrote:
> Hi Bruce-
> 
> > On Aug 20, 2020, at 3:49 PM, J. Bruce Fields <bfields@fieldses.org> wrote:
> > 
> > From: "J. Bruce Fields" <bfields@redhat.com>
> > 
> > It was an interesting idea but nobody seems to be using it, it's buggy
> > at this point, and nfs4state.c is already complicated enough without it.
> > The new nfsd/clients/ code provides some of the same functionality, and
> > could probably do more if desired.
> 
> Maybe this should mention that the feature has been deprecated since
> 9d60d93198c6 ("Deprecate nfsd fault injection").

Thanks, done.

--b.
