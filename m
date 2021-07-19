Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 186803CEFD1
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jul 2021 01:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344325AbhGSWq0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Jul 2021 18:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387313AbhGSUD0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Jul 2021 16:03:26 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F305C061574
        for <linux-nfs@vger.kernel.org>; Mon, 19 Jul 2021 13:41:40 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id k9so2294266qtx.3
        for <linux-nfs@vger.kernel.org>; Mon, 19 Jul 2021 13:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K/VYJ+Xk68wd6Kee797wsO4yZGhHcsOEseb1eKniI5E=;
        b=icAIiEC9Hjdzwl4/iN2W4fIbyaPW+XYuagG5rjkPI+i8D0WNPnOAdjOVwtcxcKR1ap
         e9YNSY73/grv5OxSewYGfOz2XE0CXXSUqgLzAxFCOvoKvuwdVoR8iTxGEm8BqYed/bZE
         kK4J+R3h7bbeuesDSG2BMvqzAGVs7lLORzhFELfk1dyZZAsycLHAJjj9ORA3xDDIrHeF
         u3+Vu3czlIE8bL69Uz4Hbe9kdRAF6CiD8Bn9evo/GwqptvAEpt4HYL7DGlpx1ktQMh4N
         lE8QSjuy94uq/5kQ5JkWMogwzTjsNGVjfQ8wwIJ/J/O8zN8+dCZ2J4hrg25oBh+JPobm
         ydtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K/VYJ+Xk68wd6Kee797wsO4yZGhHcsOEseb1eKniI5E=;
        b=G/IrBo8zJxsmENUN7bvb4Mt9czDj3tB7UBmqdjHtBhrNrNuA7PMAZPF/nu7DyfyWW/
         1pHoFVf7QRXgBagtoAb3lbIdcviM7uHww6YLZsC3fK8SjmMIym+xFA6klRGU7I+iR8yX
         SM1/FsOkbTUagG2F7Up2N4/FLJcgTAZ2UgJgu3VtAyqE/JmkWMro3HVYhDeRiMNUnN9S
         FHg8LmGMdfnaNNqR+QZHh+U825pdaxNMKSdQXcKHkZZlhieC1dwXkodPBMEHWa/jF55F
         7TAIqyVBLjmd/rGlxyxFj1JLPlFgrTrwyXXkp4dTgku3GVWPM4Iv1/NYuFQFjEKIz0RC
         NjOQ==
X-Gm-Message-State: AOAM530Ope9f1dbv5ftwUH5itD0DSV91jD0m7oqdlpGm7+9vnkbdRrB5
        2eqMoB9Y0nlrwBisQP6KPYO/VA==
X-Google-Smtp-Source: ABdhPJxIyRSwwTaNqm36/HJu7pLyicPXiR2gHD36Jqo6NsrUZJPq21tZfkF++BUZR+mp5rB/DqFM4w==
X-Received: by 2002:a05:622a:199d:: with SMTP id u29mr12737620qtc.195.1626727443451;
        Mon, 19 Jul 2021 13:44:03 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c1::1011? ([2620:10d:c091:480::1:e95a])
        by smtp.gmail.com with ESMTPSA id r139sm3905238qka.40.2021.07.19.13.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 13:44:02 -0700 (PDT)
Subject: Re: [PATCH/RFC] NFSD: handle BTRFS subvolumes better.
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     NeilBrown <neilb@suse.de>, Christoph Hellwig <hch@infradead.org>,
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
 <15d0f450-cae5-22bc-eef3-8a973e6dda27@toxicpanda.com>
 <20210719200003.GA32471@fieldses.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <56bd8b67-a72c-1946-e877-838d9c0c65bd@toxicpanda.com>
Date:   Mon, 19 Jul 2021 16:44:00 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210719200003.GA32471@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 7/19/21 4:00 PM, J. Bruce Fields wrote:
> On Mon, Jul 19, 2021 at 11:40:28AM -0400, Josef Bacik wrote:
>> Ok so setting aside btrfs for the moment, how does NFS deal with
>> exporting a directory that has multiple other file systems under
>> that tree?  I assume the same sort of problem doesn't occur, but why
>> is that?  Is it because it's a different vfsmount/sb or is there
>> some other magic making this work?  Thanks,
> 
> There are two main ways an NFS client can look up a file: by name or by
> filehandle.  The former's the normal filesystem directory lookup that
> we're used to.  If the name refers to a mountpoint, the server can cross
> into the mounted filesystem like anyone else.
> 
> It's the lookup by filehandle that's interesting.  Typically the
> filehandle includes a UUID and an inode number.  The server looks up the
> UUID with some help from mountd, and that gives a superblock that nfsd
> can use for the inode lookup.
> 
> As Neil says, mountd does that basically by searching among mounted
> filesystems for one with that uuid.
> 
> So if you wanted to be able to handle a uuid for a filesystem that's not
> even mounted yet, you'd need some new mechanism to look up such uuids.
> 
> That's something we don't currently support but that we'd need to
> support if BTRFS subvolumes were automounted.  (And it might have other
> uses as well.)
> 
> But I'm not entirely sure if that answers your question....
> 

Right, because btrfs handles the filehandles ourselves properly with the 
export_operations and we encode the subvolume id's into those things to make 
sure we can always do the proper lookup.

I suppose the real problem is that NFS is exposing the inode->i_ino to the 
client without understanding that it's on a different subvolume.

Our trick of simply allocating an anonymous bdev every time you wander into a 
subvolume to get a unique st_dev doesn't help you guys because you are looking 
for mounted file systems.

I'm not concerned about the FH case, because for that it's already been crafted 
by btrfs and we know what to do with it, so it's always going to be correct.

The actual problem is that we can do

getattr(/file1)
getattr(/snap/file1)

on the client and the NFS server just blind sends i_ino with the same fsid 
because / and /snap are the same fsid.

Which brings us back to what HCH is complaining about.  In his view if we had a 
vfsmount for /snap then you would know that it was a different fs.  However that 
would only actually work if we generated a completely different superblock and 
thus gave /snap a unique fsid, right?

If we did the automount thing, and the NFS server went down and came back up and 
got a getattr(/snap/file1) from a previously generated FH it would still work 
right, because it would come into the export_operations with the format that 
btrfs is expecting and it would be able to do the lookup.  This FH lookup would 
do the automount magic it needs to and then NFS would have the fsid it needs, 
correct?  Thanks,

Josef
