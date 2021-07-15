Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441293CA4E6
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jul 2021 20:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237114AbhGOSEJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Jul 2021 14:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237099AbhGOSEJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Jul 2021 14:04:09 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD5AC06175F
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jul 2021 11:01:15 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id c9so5145129qte.6
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jul 2021 11:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z0Gk2SeFQAuabVMnx7xvlDltWtB4GVuvBbjKfVTW53E=;
        b=U1UMjmFdrYSaRSKHzjI4EvNxYqUYc/WS/hsktV+dGKYUxN0o0GpfjmXEx67j00m0WK
         mETCsF7HPd7zgNxtdZkjT8fhSciLvURI+iUSFscc8AFjgIqGs1cmf7Crn8OBoAb+rm5i
         x8Q+ohSDtuhn7Y6xO/tLnYEpIDZJU/jdoasA6hjC/JOGbULn7HToTOX85abOXYY2zUdQ
         rAXXjAd0MovAyYFScIMAihuzkR/6JG+HsBMzGxrwvghs7jLI+JHE2dvGklFLNNt3oFDT
         J094+yVpMicxb7G6D8JMS9nVfWFn97H2Xk3Htesy7LLRwvRkGuv2IV48LxaEyzWmGKOa
         oq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z0Gk2SeFQAuabVMnx7xvlDltWtB4GVuvBbjKfVTW53E=;
        b=WOHBhahONLt+VSxmwmRXYUb0UKmRmWWAFxuYe/0mLFFTa83yr4xPa7zKtXkqNTavB7
         WQyYJrd9EPWugP6ARGsS8IFGsECl9y1lwuKNEg73Q/XVcZeK3ltxhK+L7HvWbgQfrrEY
         u0r0s/XzWYpyypq2g1vu+4CYkSGzOtiq2SX1m48KXWuM6cMYVQ8S5u0mh3CI97+FtstF
         T3UAcRMmFO+rBcAzOv1qK8KS3krifR6zHui74e3aGB2KZ2NTtxzDtZKIhZqYuRObc5ZY
         cZZc3Ikl5VaxVt3FJE8+9pao6RY+CSRqAjCcinCmSse60ePHTEyeTrYG6jlri1PpBsrQ
         zZ4Q==
X-Gm-Message-State: AOAM533q8BpTsS2vXAiQB0lM+1GARjHLzsne1LH1TIpoBG+pdYgqavwY
        xc+DQHRK11U22dqDMMKsmXoi1Q==
X-Google-Smtp-Source: ABdhPJw4J3ltGxdYa36s8OL2XwAUbwirLz5bKEp24g0Hd4+ZvKM02XIA9QJdPoVrM3gA6OcGVd3ZMA==
X-Received: by 2002:ac8:5f4b:: with SMTP id y11mr5009123qta.288.1626372074496;
        Thu, 15 Jul 2021 11:01:14 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11e8::11fa? ([2620:10d:c091:480::1:7357])
        by smtp.gmail.com with ESMTPSA id e12sm2364268qtj.3.2021.07.15.11.01.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 11:01:13 -0700 (PDT)
Subject: Re: [PATCH/RFC] NFSD: handle BTRFS subvolumes better.
To:     Christoph Hellwig <hch@infradead.org>
Cc:     NeilBrown <neilb@suse.de>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-nfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Ulli Horlacher <framstag@rus.uni-stuttgart.de>,
        linux-btrfs@vger.kernel.org
References: <20210613115313.BC59.409509F4@e16-tech.com>
 <20210310074620.GA2158@tik.uni-stuttgart.de>
 <162632387205.13764.6196748476850020429@noble.neil.brown.name>
 <edd94b15-90df-c540-b9aa-8eac89b6713b@toxicpanda.com>
 <YPBmGknHpFb06fnD@infradead.org>
 <28bb883d-8d14-f11a-b37f-d8e71118f87f@toxicpanda.com>
 <YPBvUfCNmv0ElBpo@infradead.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e1d9caad-e4c7-09d4-b145-5397b24e1cc7@toxicpanda.com>
Date:   Thu, 15 Jul 2021 14:01:11 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPBvUfCNmv0ElBpo@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 7/15/21 1:24 PM, Christoph Hellwig wrote:
> On Thu, Jul 15, 2021 at 01:11:29PM -0400, Josef Bacik wrote:
>> Because there's no alternative.  We need a way to tell userspace they've
>> wandered into a different inode namespace.  There's no argument that what
>> we're doing is ugly, but there's never been a clear "do X instead".  Just a
>> lot of whinging that btrfs is broken.  This makes userspace happy and is
>> simple and straightforward.  I'm open to alternatives, but there have been 0
>> workable alternatives proposed in the last decade of complaining about it.
> 
> Make sure we cross a vfsmount when crossing the "st_dev" domain so
> that it is properly reported.   Suggested many times and ignored all
> the time beause it requires a bit of work.
> 

You keep telling me this but forgetting that I did all this work when you 
originally suggested it.  The problem I ran into was the automount stuff 
requires that we have a completely different superblock for every vfsmount. 
This is fine for things like nfs or samba where the automount literally points 
to a completely different mount, but doesn't work for btrfs where it's on the 
same file system.  If you have 1000 subvolumes and run sync() you're going to 
write the superblock 1000 times for the same file system.  You are going to 
reclaim inodes on the same file system 1000 times.  You are going to reclaim 
dcache on the same filesytem 1000 times.  You are also going to pin 1000 
dentries/inodes into memory whenever you wander into these things because the 
super is going to hold them open.

This is not a workable solution.  It's not a matter of simply tying into 
existing infrastructure, we'd have to completely rework how the VFS deals with 
this stuff in order to be reasonable.  And when I brought this up to Al he told 
me I was insane and we absolutely had to have a different SB for every vfsmount, 
which means we can't use vfsmount for this, which means we don't have any other 
options.  Thanks,

Josef
