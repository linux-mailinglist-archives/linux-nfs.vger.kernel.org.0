Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 414A0152640
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Feb 2020 07:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725497AbgBEGW6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Feb 2020 01:22:58 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43633 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgBEGW6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Feb 2020 01:22:58 -0500
Received: by mail-pl1-f195.google.com with SMTP id p11so432563plq.10;
        Tue, 04 Feb 2020 22:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mauBHH5fUIpPlsDT5bUwCSAsDlzxuBk0qO1ZAB/P2Pk=;
        b=SYXh5L3ABhf6rmXur68fhQQxu8VUkfUrCb65JU1gfrP50fnCsOcG/Z2cuM1pGEh0Nh
         MPRhS+Az+AocAQygbGKICPdbr7fBJOh0mvQvoCrk8X6/j/99Qvrhtwc/NysLdaeLW2LA
         NWmg5iixX93p5QWWYoNlfXDLdJYp0oWcq8BAp5TzMFfqamKz97JMsgkdEmtb6QUkpjP5
         1zGJMcQ6N5Pyt6BEGwCbZHD7QshkWMs8e5BS2xvpIAuZwVreTgrEc2M8jFqLQvhS/WtX
         mY7XC5KlldEqc/1LC5MdJ7E1AAua1+nnKb++RFmUWTYvo3foljTcvlAulHphtSXO3TxS
         4pSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mauBHH5fUIpPlsDT5bUwCSAsDlzxuBk0qO1ZAB/P2Pk=;
        b=Wr5PoblElcl4j2mW8BYH+A7VBfSsFdEmbS2CnYUOyDGv5zZhwVxXJDzmSk14+YJNYp
         3zaI+1CrxqvzcNeoPN4FVrMgtKUCUDWfCSI3V66IRgxgvhe/5AZW1kq6Rv1UpkJDH19U
         QJNSa3P2rwfLLaofMccPxAAEizryBRldJv7bZ+P670JYJOXkN7f4eY/ezIOREi0LrH/f
         IMR+CZaSXBCNhBxPXMZBEW9nTTppAWzaiUkxpekMHEoJSOQ/iP9hyjW+NA/JbJr8R9/w
         MbtK32s38tpqQxq5FMhZfCDIfRlj8Xc1ALrwdN4/+XRFt3SYPLKHmtnEuhnDT3VjZYsg
         r6Cg==
X-Gm-Message-State: APjAAAUdYtyQJ28DccGU8KCg9CVRSpCWQOmn6zWDZTJoSuyEifBhhAYL
        BlGFJ9/+Ms8rAMqmIejy0Ok=
X-Google-Smtp-Source: APXvYqyw75a2O3A7oMNLhRYXBgnIVA4Hse+jQyQWpe7d08uMZXmRw2u7RFExZDhTeK05fJ39AhFz2w==
X-Received: by 2002:a17:902:6944:: with SMTP id k4mr19691878plt.214.1580883777686;
        Tue, 04 Feb 2020 22:22:57 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id ev5sm5783095pjb.4.2020.02.04.22.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 22:22:57 -0800 (PST)
Date:   Wed, 5 Feb 2020 14:22:49 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Murphy Zhou <jencce.kernel@gmail.com>,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: A NFS, xfs, reflink and rmapbt story
Message-ID: <20200205062249.pwqcg5nlghcuy5lg@xzhoux.usersys.redhat.com>
References: <20200123083217.flkl6tkyr4b7zwuk@xzhoux.usersys.redhat.com>
 <20200124011019.GA8247@magnolia>
 <20200127223631.GA28982@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127223631.GA28982@fieldses.org>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jan 27, 2020 at 05:36:31PM -0500, J. Bruce Fields wrote:
> On Thu, Jan 23, 2020 at 05:10:19PM -0800, Darrick J. Wong wrote:
> > On Thu, Jan 23, 2020 at 04:32:17PM +0800, Murphy Zhou wrote:
> > > Hi,
> > > 
> > > Deleting the files left by generic/175 costs too much time when testing
> > > on NFSv4.2 exporting xfs with rmapbt=1.
> > > 
> > > "./check -nfs generic/175 generic/176" should reproduce it.
> > > 
> > > My test bed is a 16c8G vm.
> > 
> > What kind of storage?
> > 
> > > NFSv4.2  rmapbt=1   24h+
> > 
> > <URK> Wow.  I wonder what about NFS makes us so slow now?  Synchronous
> > transactions on the inactivation?  (speculates wildly at the end of the
> > workday)
> > 
> > I'll have a look in the morning.  It might take me a while to remember
> > how to set up NFS42 :)
> 
> It may just be the default on a recent enough distro.
> 
> Though I'd be a little surprised if this behavior is specific to the
> protocol version.

This testcase requires reflink, which is only available in v4.2.
On other protocols, this testase does not run.

Murphy

> 
> nfsd_unlink() is basically just vfs_unlink() followed by
> commit_metadata().
> 
> --b.
> 
> > 
> > --D
> > 
> > > NFSv4.2  rmapbt=0   1h-2h
> > > xfs      rmapbt=1   10m+
> > > 
> > > At first I thought it hung, turns out it was just slow when deleting
> > > 2 massive reflined files.
> > > 
> > > It's reproducible using latest Linus tree, and Darrick's deferred-inactivation
> > > branch. Run latest for-next branch xfsprogs.
> > > 
> > > I'm not sure it's something wrong, just sharing with you guys. I don't
> > > remember I have identified this as a regression. It should be there for
> > > a long time.
> > > 
> > > Sending to xfs and nfs because it looks like all related. :)
> > > 
> > > This almost gets lost in my list. Not much information recorded, some
> > > trace-cmd outputs for your info. It's easy to reproduce. If it's
> > > interesting to you and need any info, feel free to ask.
> > > 
> > > Thanks,
> > > 
> > > 
> > > 7)   0.279 us    |  xfs_btree_get_block [xfs]();
> > > 7)   0.303 us    |  xfs_btree_rec_offset [xfs]();
> > > 7)   0.301 us    |  xfs_rmapbt_init_high_key_from_rec [xfs]();
> > > 7)   0.356 us    |  xfs_rmapbt_diff_two_keys [xfs]();
> > > 7)   0.305 us    |  xfs_rmapbt_init_key_from_rec [xfs]();
> > > 7)   0.306 us    |  xfs_rmapbt_diff_two_keys [xfs]();
> > > 7)               |  xfs_rmap_query_range_helper [xfs]() {
> > > 7)   0.279 us    |    xfs_rmap_btrec_to_irec [xfs]();
> > > 7)               |    xfs_rmap_lookup_le_range_helper [xfs]() {
> > > 1)   0.786 us    |  _raw_spin_lock_irqsave();
> > > 7)               |      /* xfs_rmap_lookup_le_range_candidate: dev 8:34 agno 2 agbno 6416 len 256 owner 67160161 offset 99284480 flags 0x0 */
> > > 7)   0.506 us    |    }
> > > 7)   1.680 us    |  }
