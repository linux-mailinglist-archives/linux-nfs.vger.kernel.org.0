Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F18BD5C953
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2019 08:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbfGBGbn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Jul 2019 02:31:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfGBGbn (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 2 Jul 2019 02:31:43 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 658CF20881;
        Tue,  2 Jul 2019 06:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562049102;
        bh=82ee/JqwTflIBeAwu9pJlPEalam46uYT6iLFFaMkRDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SlEwihVh6ZclZbvkbDK36qIxxxrKoBvhLP7kaWBhN4PmW9yc6vI/LrX0s86y6PB7y
         +Z5T9PAoIO0Gq2zxseLKE1EA+YjMQT335cc6jXOLAVkeyrBeHXAhijpXBHBw9qH4dI
         R2kYh0P9ljaxqKkp0yc1txHFUR3HafjGtWR5BRMI=
Date:   Mon, 1 Jul 2019 23:31:40 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     syzbot <syzbot+7fe11b49c1cc30e3fce2@syzkaller.appspotmail.com>,
        anna.schumaker@netapp.com, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        trond.myklebust@hammerspace.com
Subject: Re: memory leak in nfs_get_client
Message-ID: <20190702063140.GE3054@sol.localdomain>
References: <000000000000f8a345058b046657@google.com>
 <223AB0C9-D93E-4D3C-BBBB-4AF40D8EA436@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <223AB0C9-D93E-4D3C-BBBB-4AF40D8EA436@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jun 11, 2019 at 12:23:12PM -0400, Benjamin Coddington wrote:
> Ugh.. Now that you can cancel the wait, you have to also handle if "new" was
> allocated.  I think this needs:
> 
> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> index d7e4f0848e28..4d90f5bf0b0a 100644
> --- a/fs/nfs/client.c
> +++ b/fs/nfs/client.c
> @@ -406,10 +406,10 @@ struct nfs_client *nfs_get_client(const struct
> nfs_client_initdata *cl_init)
>                 clp = nfs_match_client(cl_init);
>                 if (clp) {
>                         spin_unlock(&nn->nfs_client_lock);
> -                       if (IS_ERR(clp))
> -                               return clp;
>                         if (new)
>                                 new->rpc_ops->free_client(new);
> +                       if (IS_ERR(clp))
> +                               return clp;
>                         return nfs_found_client(cl_init, clp);
>                 }
>                 if (new) {
> 
> I'll patch/test and send it along.
> 
> Ben

Hi Ben, what happened to this patch?

- Eric
