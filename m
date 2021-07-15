Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A423CA050
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jul 2021 16:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhGOOMe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Jul 2021 10:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbhGOOMd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Jul 2021 10:12:33 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3328C06175F
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jul 2021 07:09:39 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id p10so2874997qvk.7
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jul 2021 07:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OztbGn4jq9jEnauPPZWPubMVx5XAjWKw5amcRjbcnWY=;
        b=1yDSnMZ26A/UwPz6Haqu8Bqfa53cFDvP9Hcgm/LBQMR8T6K2OPrZT4ZPWVNH+M26Vo
         1CkkD1t5iGkkc4aJtn3aVgSYulfBoz0/FsL3Sbh8sUWE8ewXPpy0aQdcwiJh52cCx6tI
         dqwRm0oZs98ESc8DvtvahE2E5P+UXItEdlYDv27rwBJLEz23xj5ypd2hu+9j9zZ/Bxj7
         asO+z/uie5i8ZqP8hTQU/LOvJwP9whQcEKZQAzIbLTc2xs4jmyRxjWNlrwlUTK5W7Thu
         AI8wEmKE70iyLSUm6C+28iKESmLq+ZUYMcs7bRT46M0xYHrcYkWfGNPoqPnWG32NVmwT
         QTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OztbGn4jq9jEnauPPZWPubMVx5XAjWKw5amcRjbcnWY=;
        b=OBDishup1nFT0zoT7OgavyZZJ8mk367uwEQUQjLXQU4eZoMCFs+gPKpa09+FyTAIuG
         wkzXnkXjfBJBo5w7HBUzAUqgCdYJAlmQxOsj6xmTOKDVP9vL7bE/DUD7HqMcFRQhkv4V
         /g1e4d+T+6AHt6qjsOCnKltycxVIyS9kOBPx7WPaznOqWbU41vzMe8uTfe4Ae1xiscJi
         WhRSXpowYUcDUJmpoxVw2d6aTHw1dnOpRkxvXlep9RUNE6EfHQP9JXta+iL6uDx3kL8P
         qbB1U2AbI4Z7PDCASJAuWPkLa+2Sh6u5ReAQnDoaVvF9iIYx2s9lMtuSlWCVlWOkWfSz
         qr0g==
X-Gm-Message-State: AOAM5324gtYHErLgr/QGupaWq0OBuGzUvZN/jSZqQvHIu0fqzTImF7F5
        y3ml4iPkJ9P56ysCLmEviAYvQg==
X-Google-Smtp-Source: ABdhPJxvGHV22U+mfkgbII2ysKGyMcFXZ0ZHvb/Cb9zsSGXjrNNMv1SrZofqrjf38hNO4zrIFTpehg==
X-Received: by 2002:a05:6214:5098:: with SMTP id kk24mr4670221qvb.26.1626358178693;
        Thu, 15 Jul 2021 07:09:38 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x125sm2550509qkd.8.2021.07.15.07.09.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 07:09:38 -0700 (PDT)
Subject: Re: [PATCH/RFC] NFSD: handle BTRFS subvolumes better.
To:     NeilBrown <neilb@suse.de>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-nfs@vger.kernel.org, Wang Yugui <wangyugui@e16-tech.com>,
        Ulli Horlacher <framstag@rus.uni-stuttgart.de>,
        linux-btrfs@vger.kernel.org
References: <20210613115313.BC59.409509F4@e16-tech.com>
 <20210310074620.GA2158@tik.uni-stuttgart.de>
 <162632387205.13764.6196748476850020429@noble.neil.brown.name>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <edd94b15-90df-c540-b9aa-8eac89b6713b@toxicpanda.com>
Date:   Thu, 15 Jul 2021 10:09:37 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <162632387205.13764.6196748476850020429@noble.neil.brown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 7/15/21 12:37 AM, NeilBrown wrote:
> 
> Hi all,
>   the problem this patch address has been discuss on both the NFS list
>   and the BTRFS list, so I'm sending this to both.  I'd be very happy for
>   people experiencing the problem (NFS export of BTRFS subvols) who are
>   in a position to rebuild the kernel on their NFS server to test this
>   and report success (or otherwise).
> 
>   While I've tried to write this patch so that it *could* land upstream
>   (and could definitely land in a distro franken-kernel if needed), I'm
>   not completely sure it *should* land upstream.  It includes some deep
>   knowledge of BTRFS into NFSD code.  This could be removed later once
>   proper APIs are designed and provided.  I can see arguments either way
>   and wonder what others think.
> 
>   BTRFS developers:  please examine the various claims I have made about
>     BTRFS and correct any that are wrong.  The observation that
>     getdents can report the same inode number of unrelated files
>     (a file and a subvol in my case) is ... interesting.
> 
>   NFSD developers: please comment on anything else.
> 
>   Others: as I said: testing would be great! :-)
> 
> Subject: [PATCH] NFSD: handle BTRFS subvolumes better.
> 
> A single BTRFS mount can present as multiple "volumes".  i.e. multiple
> sets of objects with potentially overlapping inode number spaces.
> The st_dev presented to user-space via the stat(2) family of calls is
> different for each internal volume, as is the f_fsid reported by
> statfs().
> 
> However nfsd doesn't look at st_dev or the fsid (other than for the
> export point - typically the mount point), so it doesn't notice the
> different filesystems.  Importantly, it doesn't report a different fsid
> to the NFS client.
> 
> This leads to the NFS client reusing inode numbers, and applications
> like "find" and "du" complaining, particularly when they find a
> directory with the same st_ino and st_dev as an ancestor.  This
> typically happens with the root of a sub-volume as the root of every
> volume in BTRFS has the same inode number (256).
> 
> To fix this, we need to report a different fsid for each subvolume, but
> need to use the same fsid that we currently use for the top-level
> volume.  Changing this (by rebooting a server to new code), might
> confuse the client.  I don't think it would be a major problem (stale
> filehandles shouldn't happen), but it is best avoided.
> 
> Determining the fsid to use is a bit awkward....
> 
> There is limited space in the protocol (32 bits for NFSv3, 64 for NFSv4)
> so we cannot append the subvolume fsid.  The best option seems to be to
> hash it in.  This patch uses a simple 'xor', but possible a Jenkins hash
> would be better.
> 
> For BTRFS (and other) filesystems the current fsid is a hash (xor) of
> the uuid provided from userspace by mounted.  This is derived from the
> statfs fsid.  If we use the statfs fsid for subvolumes and xor this in,
> we risk erasing useful unique information.  So I have chosen not to use
> the statfs fsid.
> 
> Ideally we should have an API for the filesystem to report if it uses
> multiple subvolumes, and to provide a unique identifier for each.  For
> now, this patch calls exportfs_encode_fh().  If the returned fsid type
> is NOT one of those used by BTRFS, then we assume the st_fsid cannot
> change, and use the current behaviour.
> 
> If the type IS one that BTRFS uses, we use intimate knowledge of BTRFS
> to extract the root_object_id from the filehandle and record that with
> the export information.  Then when exporting an fsid, we check if
> subvolumes are enabled and if the current dentry has a different
> root_object_id to the exported volume.  If it does, the root_object_id
> is hashed (xor) into the reported fsid.
> 
> When an NFSv4 client sees that the fsid has changed, it will ask for the
> MOUNTED_ON_FILEID.  With the Linux NFS client, this is visible to
> userspace as an automount point, until content within the directory is
> accessed and the automount is triggered.  Currently the MOUNTED_ON_FILEID
> for these subvolume roots is the same as of the root - 256.  This will
> cause find et.al.  to complain until the automount actually gets mounted.
> 
> So this patch reports the MOUNTED_OF_FILEID in such cases to be a magic
> number that appears to be appropriate for BTRFS:
>      BTRFS_FIRST_FREE_OBJECTID - 1
> 
> Again, we really want an API to get this from the filesystem.  Changing
> it later has no cost, so we don't need any commitment from the btrfs team
> that this is what they will provide if/when we do get such an API.
> 
> This same problem (of an automount point with a duplicate inode number)
> also exists for NFSv3.  This problem cannot be resolved completely on
> the server as NFSv3 doesn't have a well defined "MOUNTED_ON_FILEID"
> concept, but we can come close.  The inode number returned by READDIR is
> likely to be the mounted-on-fileid.  With READDIR_PLUS, two fileids are
> returned, the one from the readdir, and (optionally) another from
> 'stat'.  Linux-NFS checks these match and if not, it treats the first as
> a mounted-on-fileid.
> 
> Interestingly BTRFS getdents() *DOES* report a different inode number
> for subvol roots than is returned by stat().  These aren't actually
> unique (!!!!) but in at least one case, they are different from
> ancestors, so this is sufficient.
> 
> NFSD currently SUPPRESSES the stat information if the inode number is
> different.  This is because there is room for a file to be renamed between
> the readdir call and the lookup_one_len() prior to getattr, and the
> results could be confusing.  However for the case of a BTRFS filesystem
> with an inode number of 256, the value of reporting the difference seems
> to exceed the cost of any confusion caused by a race (if that is even
> possible in this case).
> So this patch allows the two fileids to be different when 256 is found
> on BTRFS.
> 
> With this patch a 'du' or 'find' in an NFS-mounted btrfs filesystem
> which has snapshot subvols works correctly for both NFSv4 and NFSv3.
> Fortunately the problematic programs tend to trigger READDIR_PLUS and so
> benefit from the detection of the MOUNTED_ON_FILEID which is provides.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>

I'm going to restate what I think the problem is you're having just so I'm sure 
we're on the same page.

1. We export a btrfs volume via nfsd that has multiple subvolumes.
2. We run find, and when we stat a file, nfsd doesn't send along our bogus 
st_dev, it sends it's own thing (I assume?).  This confuses du/find because you 
get the same inode number with different parents.

Is this correct?  If that's the case then it' be relatively straightforward to 
add another callback into export_operations to grab this fsid right?  Hell we 
could simply return the objectid of the root since that's unique across the 
entire file system.  We already do our magic FH encoding to make sure we keep 
all this straight for NFS, another callback to give that info isn't going to 
kill us.  Thanks,

Josef
