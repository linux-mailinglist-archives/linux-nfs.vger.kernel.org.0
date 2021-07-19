Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF42F3CE2C0
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Jul 2021 18:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbhGSPbr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Jul 2021 11:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348026AbhGSPYT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Jul 2021 11:24:19 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDDDC0613BA
        for <linux-nfs@vger.kernel.org>; Mon, 19 Jul 2021 08:12:50 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id p10so8577321qvk.7
        for <linux-nfs@vger.kernel.org>; Mon, 19 Jul 2021 08:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qYNyXnbrp0zipIhsdIrE0Vj4ykFB3VxyqbloBGfaEzg=;
        b=pSG3jVdtNyxpOMQ5vB6ChIVo9y2cqNz/vkF3PItT4n4AnEmiG6P2//AS13uaXKKfp0
         grrq4CwXN++0rHWnQnx3SAdBm5sjy98+ENPPlhALLlA2HsZismFAKY3incBW7BGyaGbh
         D3Vc7chiX4HwpEByOW0TYx4vQWubRxN5+O/jGNVSa6urLrwVx5zepmTAyNtJZlaXi0cv
         CH6MSHLtfokAU/u5F9i9gW+Nw/6tldzFwVRaQXqGHL3zbXiTiaLa8XoEh9CX5l05oWOO
         STl88zH1qIPI2LThHQyFDZ7YZtg2ARgG9Z6rpb9w5s02uHr7Vk4HUxFHML9ZVHVaHdn7
         pBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qYNyXnbrp0zipIhsdIrE0Vj4ykFB3VxyqbloBGfaEzg=;
        b=oOSR/SvvYkAm/PUahN+vjhSk6WmjrPX+xj4IJj2wgRoTJHKvojew4NQi9a+5QXYffp
         zktROMNls7UmPjuekV3v/hXHMjUITOybgv3658YFFkKVFE/uXEpqalX52aPyhhIn5NWD
         LFVJZrM4/8CW0RiG1eNbKWEA/3ZMkRtuhBT+xyMP/v32sPaysCqrg/JIBiFqPXfcZS4B
         bLFyu0M46pONaHXvpbu5RmitzfJtMhS2z1Lx3C6YLkECGcI+9nLTw/VclxJ8FARJTdEG
         kAneQHk2sXtiby7n0g6XLeepwQzKILS1GGuJ/f2HPbisAfG7zqQ3+mj24iukGnmrTz18
         fSlA==
X-Gm-Message-State: AOAM531lBzC+O/a8oe8M+kwHjBx0+AlVzPvCEoVOuoUlP1TttYcWeNP7
        rnxuizGhnXklJtqHCDu5+r9kmA==
X-Google-Smtp-Source: ABdhPJwmG9QNYnvlNeMgXcH5zKP+UXHqeWWs6NB7DscxRfocwb6Yxd3tJ+WnL4VtdsKrOXzHPOowCQ==
X-Received: by 2002:a05:6214:443:: with SMTP id cc3mr25199042qvb.40.1626709231556;
        Mon, 19 Jul 2021 08:40:31 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n188sm6073992qke.54.2021.07.19.08.40.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 08:40:30 -0700 (PDT)
Subject: Re: [PATCH/RFC] NFSD: handle BTRFS subvolumes better.
To:     NeilBrown <neilb@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
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
 <e1d9caad-e4c7-09d4-b145-5397b24e1cc7@toxicpanda.com>
 <162638862766.13764.8566962032225976326@noble.neil.brown.name>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <15d0f450-cae5-22bc-eef3-8a973e6dda27@toxicpanda.com>
Date:   Mon, 19 Jul 2021 11:40:28 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <162638862766.13764.8566962032225976326@noble.neil.brown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 7/15/21 6:37 PM, NeilBrown wrote:
> On Fri, 16 Jul 2021, Josef Bacik wrote:
>> On 7/15/21 1:24 PM, Christoph Hellwig wrote:
>>> On Thu, Jul 15, 2021 at 01:11:29PM -0400, Josef Bacik wrote:
>>>> Because there's no alternative.  We need a way to tell userspace they've
>>>> wandered into a different inode namespace.  There's no argument that what
>>>> we're doing is ugly, but there's never been a clear "do X instead".  Just a
>>>> lot of whinging that btrfs is broken.  This makes userspace happy and is
>>>> simple and straightforward.  I'm open to alternatives, but there have been 0
>>>> workable alternatives proposed in the last decade of complaining about it.
>>>
>>> Make sure we cross a vfsmount when crossing the "st_dev" domain so
>>> that it is properly reported.   Suggested many times and ignored all
>>> the time beause it requires a bit of work.
>>>
>>
>> You keep telling me this but forgetting that I did all this work when you
>> originally suggested it.  The problem I ran into was the automount stuff
>> requires that we have a completely different superblock for every vfsmount.
>> This is fine for things like nfs or samba where the automount literally points
>> to a completely different mount, but doesn't work for btrfs where it's on the
>> same file system.  If you have 1000 subvolumes and run sync() you're going to
>> write the superblock 1000 times for the same file system.  You are going to
>> reclaim inodes on the same file system 1000 times.  You are going to reclaim
>> dcache on the same filesytem 1000 times.  You are also going to pin 1000
>> dentries/inodes into memory whenever you wander into these things because the
>> super is going to hold them open.
>>
>> This is not a workable solution.  It's not a matter of simply tying into
>> existing infrastructure, we'd have to completely rework how the VFS deals with
>> this stuff in order to be reasonable.  And when I brought this up to Al he told
>> me I was insane and we absolutely had to have a different SB for every vfsmount,
>> which means we can't use vfsmount for this, which means we don't have any other
>> options.  Thanks,
> 
> When I was first looking at this, I thought that separate vfsmnts
> and auto-mounting was the way to go "just like NFS".  NFS still shares a
> lot between the multiple superblock - certainly it shares the same
> connection to the server.
> 
> But I dropped the idea when Bruce pointed out that nfsd is not set up to
> export auto-mounted filesystems.  It needs to be able to find a
> filesystem given a UUID (extracted from a filehandle), and it does this
> by walking through the mount table to find one that matches.  So unless
> all btrfs subvols were mounted all the time (which I wouldn't propose),
> it would need major work to fix.
> 
> NFSv4 describes the fsid as having a "major" and "minor" component.
> We've never treated these as having an important meaning - just extra
> bits to encode uniqueness in.  Maybe we should have used "major" for the
> vfsmnt, and kept "minor" for the subvol.....
> 
> The idea for a single vfsmnt exposing multiple inode-name-spaces does
> appeal to me.  The "st_dev" is just part of the name, and already a
> fairly blurry part.  Thanks to bind mounts, multiple mounts can have the
> same st_dev.  I see no intrinsic reason that a single mount should not
> have multiple fsids, provided that a coherent picture is provided to
> userspace which doesn't contain too many surprises.
> 

Ok so setting aside btrfs for the moment, how does NFS deal with exporting a 
directory that has multiple other file systems under that tree?  I assume the 
same sort of problem doesn't occur, but why is that?  Is it because it's a 
different vfsmount/sb or is there some other magic making this work?  Thanks,

Josef
