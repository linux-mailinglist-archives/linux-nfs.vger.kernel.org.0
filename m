Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAE82D38AC
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2019 07:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfJKFYR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Oct 2019 01:24:17 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:53244 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfJKFYR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Oct 2019 01:24:17 -0400
Received: by mail-wm1-f48.google.com with SMTP id r19so9022821wmh.2
        for <linux-nfs@vger.kernel.org>; Thu, 10 Oct 2019 22:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=bLYpdyI6zzVGrhQVHapv2lA73UgJSsfnyltZM74rndQ=;
        b=mdGP3Ee/1U88JNrbSZwYpRZ9c8IEOoM4jh+zS6ZPokzcO193jf2NPgjI2dSg7qUCLM
         yAdVdo3B2Hdxap9IoduiJiomwSs4p4uXAHT2EIHdUiLJAGJ+jKdhbD6q0uyReDXB/4MC
         c5bwLZovNuLUkR8IchmeQfLJFECFl7bW0W9aljuQ0UjoZ3+b/959frmQ2E6MUSnYDT+G
         AXeN5b17Nbk/n/bFBGD09H4051dvNC+eg/wqLpZmVGOHOD3yGS69nFv7K5cMtcVcRHz4
         UQoYruDV6y3S8qGBRqimQH/NaQCLG2NUxQERvl8DWB6rq2i46EiEkt3TNx/4VaOtKuIm
         B3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=bLYpdyI6zzVGrhQVHapv2lA73UgJSsfnyltZM74rndQ=;
        b=oZZMrQfYJG55v/g9dM0niacldmUI38D6sCnZLVC1iTFhWP4O+OWGGlzz9dmYgSxaxo
         YDbngwsY/hSWI6kEkdsIVjzcf+MPlNbYXKn0A3iQLrlY5VopQCc5xW0XceYXw8GVNnfk
         cSMHVlqjvvPhO0Tv4WY/XeWOUITo0N7HZk5woLE805gPzsYDZABX6b7ce7s0kHNLaTZE
         DZhHedTQXHqdkvjwS4Nqy/Xq1o41ETiWebT3+jCONULXpB0kiU6Ik6YaTwjddkvw6yK3
         TPk4iOh53rDG8ZHxjuiHYac2UjHQtK3/Y7pvVqGHeVSJPlw2N9TZvrOpgJVHdR5+hUUN
         CBpg==
X-Gm-Message-State: APjAAAUj+4Ce5uCtsPY61qL4y9FukD//u5EIUcv1fw/e15AemnEGi2JS
        IS9vxpO56v7VdxkZz9hhm4LF0vLX
X-Google-Smtp-Source: APXvYqyEjVzhGhnHX58TYarfNr6GP2OeYQsSpO1wo7Ppk+/CQo0xWxHHLfTCmhnJ1vSaiBYNIw4iNQ==
X-Received: by 2002:a1c:81d7:: with SMTP id c206mr1467006wmd.175.1570771455354;
        Thu, 10 Oct 2019 22:24:15 -0700 (PDT)
Received: from [10.161.254.11] (srv1-dide.ioa.sch.gr. [81.186.20.0])
        by smtp.googlemail.com with ESMTPSA id r27sm19584187wrc.55.2019.10.10.22.24.14
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 22:24:14 -0700 (PDT)
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
From:   Alkis Georgopoulos <alkisg@gmail.com>
Subject: bindfs over NFS shows the underlying file system
Message-ID: <ae761918-245e-e25c-7aab-dd465f7c2461@gmail.com>
Date:   Fri, 11 Oct 2019 08:24:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I'm not sure if this is an NFS issue, or a bindfs issue, or if I'm not 
using the appropriate NFS options.

I export my /home via NFS with:

     /home *(rw,async,crossmnt,no_subtree_check,no_root_squash,insecure)

Inside my /home I'm providing a shared folder with a bindfs mount:

     bindfs -u 1000 --create-for-user=1000 -g 100 --create-for-group=100 
-p 770,af-x /home/share /home/share

I.e. this just sets fixed permissions for anything under /home/share.

And finally I mount /home on some NFS client (or on localhost):

     mount -t nfs server:/home /home

The problem is that /home/share on the client doesn't show the bindfs 
permissions, but it shows the underlying file system of the server's 
/home/share.
The crossmnt NFS option follows submounts with other file systems, but 
not with bindfs.

On the other hand, if the bindfs source is on a different file system 
than the bindfs target directory, everything works fine (i.e. bindfs 
/other/filesystem/share /home/share).

Is there any way to configure either NFS or bindfs, so that this works 
when I only have one partition, i.e. when the share is on the same file 
system as /home?

If anyone answers, please Cc me as I'm not in the list.

Thank you very much,
Alkis Georgopoulos
LTSP developer
