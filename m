Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530A94402FB
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Oct 2021 21:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhJ2TRG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Oct 2021 15:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhJ2TRF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Oct 2021 15:17:05 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF2EC061570
        for <linux-nfs@vger.kernel.org>; Fri, 29 Oct 2021 12:14:36 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id BE19D6EC3; Fri, 29 Oct 2021 15:14:35 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org BE19D6EC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1635534875;
        bh=1JhjnaCR+szNU9tGbtubF08wnnOtETMb+F1e+/mxP1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yChLxyx6pRfgcNgs/6c5scVcxx1fswvFCUe6BmCB7CXvIUjx8DGJ+7Nm0ojQQdiwd
         Raz8L/ANDMgstbJkRvyQa96apnJQqo7bgDr2ruP2olPTCgMc1AUwVZkh1ZulgNPcl1
         72wwJlx2r2QO9JLC4EWNxNPiMiHs14z9mW/zkLhE=
Date:   Fri, 29 Oct 2021 15:14:35 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Steve Dickson <steved@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/1] Enable inter server to server copies on a export
Message-ID: <20211029191435.GI19967@fieldses.org>
References: <20211028144851.644018-1-steved@redhat.com>
 <20211029134534.GA19967@fieldses.org>
 <3e928624-6a7a-8583-7ea4-4eef9c22488e@redhat.com>
 <20211029164058.GE19967@fieldses.org>
 <65b31c94-54aa-5035-546c-75eb0048ba96@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65b31c94-54aa-5035-546c-75eb0048ba96@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Oct 29, 2021 at 01:30:36PM -0400, Steve Dickson wrote:
> On 10/29/21 12:40, J. Bruce Fields wrote:
> >Let's just stick with that for now, and leave it off by default until
> >we're sure it's mature enough.  Let's not introduce new configuration to
> >work around problems that we haven't really analyzed yet.
> How is this going to find problems? At least with the export option
> it is documented

That sounds fixable.  We need documentation of module parameters anyway.

> and it more if a stick you toe in the pool verses
> jumping in...

If we want more fine-grained control, I'm not yet seeing the argument
that an export option on the destination server side is the way to do
it.

Let's document the module parameter and go with that for now.

--b.
