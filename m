Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39D1AD4D19
	for <lists+linux-nfs@lfdr.de>; Sat, 12 Oct 2019 07:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfJLFDe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 12 Oct 2019 01:03:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39550 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfJLFDe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 12 Oct 2019 01:03:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id r3so13945444wrj.6
        for <linux-nfs@vger.kernel.org>; Fri, 11 Oct 2019 22:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=yb9wUYBRsd6chnj9Lxu/0JciW201D34X8it/n1SBujU=;
        b=mfNjTkwLcu+fMgKIqaV79qcZo2/J7K8GON+tJC3iNebUcUS8QKO0jWVz4I13IcqFGN
         ovPzDDoA+MJGK3ZPJpk09yXMLy0Ige7NWFG+S/sx0Lea3J5WqksYtohzlcQjLbR8TH7D
         RJh++wuaooTboIebL6ESNzg7WM9BfI5r0qjh6OsvatjG+Qs1OfZ9Y8wfTOW5IMj3Fyll
         d2D4qX1uII9jIW7hc5Q5AF/8ENoAFPcKAky41LjFoR0PZFGVmx4tHwHDGe/Z5SeC5rTB
         YZe+oQb+PaQy5iU1U2UzY5otgeLN++mS2TFIqvaum279W+2SAezgoYwyqF31QqiozIp4
         xpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yb9wUYBRsd6chnj9Lxu/0JciW201D34X8it/n1SBujU=;
        b=VWV+sLRs/Ew9ab8lyvNRNKuM9zTjcpy8IjsT43T+rZT6QNUQgPlnDNoKqUsuo10Mh5
         kLa24UQYylzkqGUOxMtyhAY2AEcIFjpO4uHaTek6shCepyxRBtPh+aiUWOBa9ykwAYDn
         k9v6v/Hjhv3mO4FsTq8/TAJWk96ooo2TVuUmiGtS0Nm9LZU/cgVsKYUbrWCD5F3TTnCh
         0hQj6tuM2+/mDDMKt9OKMUuGqbf+PHOQ3EjE1K4bXy3v8sqlljBbzI6J8lTkF1cnZlT8
         2LheDGJGkjZHq0iveO9PtcgxXhhJh8iUvbY33gIcy+MZYuuPgIUSvqGvrtRF04ALhEbL
         FtBw==
X-Gm-Message-State: APjAAAUtW0ROiXv1nLSpRM9B84qvyVokMXlnYmUTnmFFnu8MMBHg1r+r
        oBOEnVhwP/8/ddmcjCm4eVHYW/ym
X-Google-Smtp-Source: APXvYqyFkjyxfTDM2wabsFYGC2QidJsxKdN0z8vKSAoCO5Ga+K3GoDOG+HVLLdccNLCxhkrVhIqeiQ==
X-Received: by 2002:a5d:6942:: with SMTP id r2mr15248072wrw.363.1570856611552;
        Fri, 11 Oct 2019 22:03:31 -0700 (PDT)
Received: from [10.161.254.11] (srv1-dide.ioa.sch.gr. [81.186.20.0])
        by smtp.googlemail.com with ESMTPSA id l13sm11360619wmj.25.2019.10.11.22.03.30
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Oct 2019 22:03:31 -0700 (PDT)
Subject: Re: bindfs over NFS shows the underlying file system
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <ae761918-245e-e25c-7aab-dd465f7c2461@gmail.com>
 <20191011164722.GB19318@fieldses.org>
From:   Alkis Georgopoulos <alkisg@gmail.com>
Message-ID: <19e17427-e0e7-ec90-3665-09112c96a6bc@gmail.com>
Date:   Sat, 12 Oct 2019 08:03:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191011164722.GB19318@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thank you very much for the feedback,

I'm testing with Ubuntu 18.04, nfs-common 1:1.3.4-2.1ubuntu5.2.
I think this means "nfs utils 1.3.4".

I tried explicitly listing all submounts in exports, and specifying an 
fsid everywhere, and that worked, for example:

exports:
/home 
*(fsid=4858dab5b4ac16ad2b7d274698c2532a,rw,async,crossmnt,no_subtree_check,no_root_squash,insecure)
/home/share 
*(fsid=8c1748909cac2548372caead5bab9aa5,rw,async,no_subtree_check,no_root_squash,insecure)

...and the clients only mount /home, and then properly see the bindfs 
share permissions.

But I'd really like to avoid that as in the real scenario there are many 
submounts which are frequently added/removed, not just /home/share.

I'll try to follow your advice for debugging information.



On 10/11/19 7:47 PM, J. Bruce Fields wrote:
> On Fri, Oct 11, 2019 at 08:24:14AM +0300, Alkis Georgopoulos wrote:
>> I'm not sure if this is an NFS issue, or a bindfs issue, or if I'm
>> not using the appropriate NFS options.
>>
>> I export my /home via NFS with:
>>
>>      /home *(rw,async,crossmnt,no_subtree_check,no_root_squash,insecure)
>>
>> Inside my /home I'm providing a shared folder with a bindfs mount:
>>
>>      bindfs -u 1000 --create-for-user=1000 -g 100
>> --create-for-group=100 -p 770,af-x /home/share /home/share
>>
>> I.e. this just sets fixed permissions for anything under /home/share.
>>
>> And finally I mount /home on some NFS client (or on localhost):
>>
>>      mount -t nfs server:/home /home
>>
>> The problem is that /home/share on the client doesn't show the
>> bindfs permissions, but it shows the underlying file system of the
>> server's /home/share.
>> The crossmnt NFS option follows submounts with other file systems,
>> but not with bindfs.
>>
>> On the other hand, if the bindfs source is on a different file
>> system than the bindfs target directory, everything works fine (i.e.
>> bindfs /other/filesystem/share /home/share).
> 
> Huh.  I wonder if nfsd is for some reason determining the existence of a
> mountpoint by comparing some kind of filesystem id and not seeing a
> change.  Looking at the code to remind myself how this works....
> 
> nfsd_mountpoint() is using d_mountpoint() and follow_down(), which
> should be right.  Then it's making an upcall to mountd.  That's handled
> by nfs-utils/mountd/cache.c:nfsd_export().
> 
> The is_mountpoint() check there is indeed going to return false in your
> case because it's just comparing inode and device numbers....  But I
> think that case is only for the "mountpoint" export option.
> 
> So I think all that matters is that export_matches() does the right
> thing, and it certainly looks like it does--it should succeed as long as
> there's a parent directory that's exported with crossmnt.
> 
> There's some debugging you could try by looking at
> net/sunrpc/nfsd.*/content or using strace to watch rpc.mountd's reads
> and writes of net/sunrpc/nfsd.*/channel.
> 
> What version of nfs-utils are you on?
> 
> --b.
> 
>>
>> Is there any way to configure either NFS or bindfs, so that this
>> works when I only have one partition, i.e. when the share is on the
>> same file system as /home?
>>
>> If anyone answers, please Cc me as I'm not in the list.
>>
>> Thank you very much,
>> Alkis Georgopoulos
>> LTSP developer

