Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABCA625CF8E
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Sep 2020 05:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbgIDDEV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Sep 2020 23:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729620AbgIDDEU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Sep 2020 23:04:20 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D11C061244
        for <linux-nfs@vger.kernel.org>; Thu,  3 Sep 2020 20:04:19 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e33so3608107pgm.0
        for <linux-nfs@vger.kernel.org>; Thu, 03 Sep 2020 20:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kIE4YTR0d3lzNKd5ZEgHf8nCQthQ7AQl9cM6behkAGk=;
        b=kg8NTWrBtlEUXCjrPObhEe8oY63cUJVs5zILw8NmEnkSjwrFPuYusHryUdNI24ZG6k
         SFObHST+a41HZWuLG1qLAn0l/Yt3S8E3MON7JljAx+EOFhusohOux7klJkKigS+rTFRv
         mS8gTINUYeDpVSPWMpNtjkTv7q5XjluABwkvW0D5Idajp9rgZNuJJ6N4rIzo6/LW2nSS
         ms1+jzgKKjOerAGCM7Rt2bfO9ORvUycd1TFiZkkVxKFzA5eJlUG2PWnI7p8cBfpUhXms
         x7ev8ZbtCsx7SaxF00ds76CQTTfLbJKfzes8+FZvpX7rkmuoQSth0l9RVT/1RxuOkXog
         Ayvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kIE4YTR0d3lzNKd5ZEgHf8nCQthQ7AQl9cM6behkAGk=;
        b=oiN+jMQHlu32xK5rV9+SfnhXdRoET2K4BLfsGgZqFp7vlX2vxSjr1GNd3T9GPh776B
         vmm2A8UDHB9yvJIThrbqspPdxgUNuLhW9Yl3pcx7IsbF2IGmGt99UlZ1nf9lhQNnT0jp
         NwLhRkpUtRAqz54voqlZsO/SCM0nnCVSO610fMh8DuYfP6pWwLjmO/g9dNew2i5cnL6J
         CLthQWPqcLM+bbH9vvVLJYK0aolcGKQDyuCdL8Tdbf9w+Zv2tTksjIR1OZ2P926crNld
         1LBhYzKLsnEVGgnd/6a7WuD+lLSbkDstc/kDAqxBLRM6OefhqpPvPZqTkKU+VHPg6NB6
         hZBQ==
X-Gm-Message-State: AOAM530f+auW/DB+VSXx6DmZH9daMN7QeEehwB+D8uUxaiyYlOi44pqt
        pa+/CDaFUX5Ynzi4Gzo4U+Q=
X-Google-Smtp-Source: ABdhPJxRxSW6arGx/4d+vUBPLaywws5zg/Zsv+u5FwfWNLKKRaRtCTPs/DPzRe8DQbrz2UbVJaM+Hg==
X-Received: by 2002:aa7:92c7:: with SMTP id k7mr6585980pfa.239.1599188659423;
        Thu, 03 Sep 2020 20:04:19 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id t5sm3685039pji.51.2020.09.03.20.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 20:04:18 -0700 (PDT)
Date:   Fri, 4 Sep 2020 11:04:11 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>, jencce.kernel@gmail.com,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFSv4: fix stateid refreshing when CLOSE racing with OPEN
Message-ID: <20200904030411.enioqeng4wxftucd@xzhoux.usersys.redhat.com>
References: <20191010074020.o2uwtuyegtmfdlze@XZHOUW.usersys.redhat.com>
 <f81d80f09c59d78c32fddd535b5604bc05c2a2b5.camel@hammerspace.com>
 <20191011084910.joa3ptovudasyo7u@xzhoux.usersys.redhat.com>
 <cbe6a84f9cd61a8f60e70c05a07b3247030a262f.camel@hammerspace.com>
 <6AAFBD30-1931-49A8-8120-B7171B0DA01C@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6AAFBD30-1931-49A8-8120-B7171B0DA01C@redhat.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Benjamin,

On Thu, Sep 03, 2020 at 01:54:26PM -0400, Benjamin Coddington wrote:
> 
> On 11 Oct 2019, at 10:14, Trond Myklebust wrote:
> > On Fri, 2019-10-11 at 16:49 +0800, Murphy Zhou wrote:
> >> On Thu, Oct 10, 2019 at 02:46:40PM +0000, Trond Myklebust wrote:
> >>> On Thu, 2019-10-10 at 15:40 +0800, Murphy Zhou wrote:
> ...
> >>>> @@ -3367,14 +3368,16 @@ static bool
> >>>> nfs4_refresh_open_old_stateid(nfs4_stateid *dst,
> >>>>  			break;
> >>>>  		}
> >>>>  		seqid_open = state->open_stateid.seqid;
> >>>> -		if (read_seqretry(&state->seqlock, seq))
> >>>> -			continue;
> >>>>
> >>>>  		dst_seqid = be32_to_cpu(dst->seqid);
> >>>> -		if ((s32)(dst_seqid - be32_to_cpu(seqid_open)) >= 0)
> >>>> +		if ((s32)(dst_seqid - be32_to_cpu(seqid_open)) > 0)
> >>>>  			dst->seqid = cpu_to_be32(dst_seqid + 1);
> >>>
> >>> This negates the whole intention of the patch you reference in the
> >>> 'Fixes:', which was to allow us to CLOSE files even if seqid bumps
> >>> have
> >>> been lost due to interrupted RPC calls e.g. when using 'soft' or
> >>> 'softerr' mounts.
> >>> With the above change, the check could just be tossed out
> >>> altogether,
> >>> because dst_seqid will never become larger than seqid_open.
> >>
> >> Hmm.. I got it wrong. Thanks for the explanation.
> >
> > So to be clear: I'm not saying that what you describe is not a problem.
> > I'm just saying that the fix you propose is really no better than
> > reverting the entire patch. I'd prefer not to do that, and would rather
> > see us look for ways to fix both problems, but if we can't find such as
> > fix then that would be the better solution.
> 
> Hi Trond and Murphy Zhou,
> 
> Sorry to resurrect this old thread, but I'm wondering if any progress was
> made on this front.

This failure stoped showing up since v5.6-rc1 release cycle
in my records. Can you reproduce this on latest upstream kernel?

Thanks!

> 
> I'm seeing this race manifest when process is never able to escape from the
> loop in nfs_set_open_stateid_locked() if CLOSE comes through first and
> clears out the state.  We can play bit-fiddling games to fix that, but I
> feel like we'll just end up breaking it again later with another fix.
> 
> Either we should revert 0e0cb35b417f, or talk about how to fix it.  Seems
> like we should be able to put the CLOSE on the nfs4_state->waitq as well,
> and see if we can't just take that approach anytime our operations get out
> of sequence.  Do you see any problems with this approach?
> 
> Ben
> 

-- 
Murphy
