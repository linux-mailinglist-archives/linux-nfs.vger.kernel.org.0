Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5543630E4DC
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Feb 2021 22:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhBCVVX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Feb 2021 16:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhBCVVW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Feb 2021 16:21:22 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F266C061573
        for <linux-nfs@vger.kernel.org>; Wed,  3 Feb 2021 13:20:41 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id bl23so1434311ejb.5
        for <linux-nfs@vger.kernel.org>; Wed, 03 Feb 2021 13:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+i7Fbby6koCWySpt5IeWtiZv0Jn7cmBlsI9o+GJsTPc=;
        b=vNMtd4SXhvB6NJT1hKVaH0bVwvnJ9b5xm7muPcFLAs5EWySTe/sUOaMT+nX5DfjqD2
         QcmZilbpXb5J0BqO5iVClTE9VprBdu0GxBbxs4hGC9CSt04eqbqP07DIhMyOv/4HLGeI
         NPc/ZaAYpYgaJo72CdAE3/7j1XfHtGi+wL8vMl+7TNSabNh93bK9k/x59bvvUgSlhmdp
         /laP4hTbQv4R3T9rrvz8ur/y4GSPPiKvoytvr9BNNY4AMr34YkIuDRdphHbu0oSVfn36
         a/+BTG8ziJu9b+5UsxCHMrAiNCkL8QBpmKhgvcH/1STEsW7BQA41qf1rGp6vE3b9H+GA
         zq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+i7Fbby6koCWySpt5IeWtiZv0Jn7cmBlsI9o+GJsTPc=;
        b=E054Ktp7XN1gnvxMSyHUe4eKj0Cj1gWapiuYHtKN39zXOTTWbjbOCKIyZ0ZjqntPaS
         R/e4UpfyM6b46ynraZb+koUYsAlk9CvBSdpJUpnidjM0oTALsE0u8MDFLvbUY1b8iQs0
         l4Ygt8ziPhTx5OUy2gY6Cxs6wlkdTyvgG1UYMDN3c7yVelF0QSEdtJkfp9HUA5xDDZx1
         3ThCOFF+CfN7L9waLRPSWOVDWnuuHMlc2WHPxcJouB7TGhtXHOGCGPXRE/wvIcmF01Xg
         0xzwljViV27UZk6pxN0sjeHrZn9NcW+oIPKiWgwT30sZ7KhB4gVuEbynYX0A7isq2tT+
         dnlQ==
X-Gm-Message-State: AOAM531GgbTaRqvBQ0pQO6bvQE1IT+9xa2SAxoenmSOzFSfBcTmwAUrn
        id2y8csk4LUyD+aGzF7pVR/Dow==
X-Google-Smtp-Source: ABdhPJw80bCbuCtsu7/4U6KnD+I0JJ0l93vbnHqCOk24IfYgftBWfWlQhVBBaEW7Bd/9YEvednmSEA==
X-Received: by 2002:a17:906:494c:: with SMTP id f12mr5243078ejt.56.1612387240066;
        Wed, 03 Feb 2021 13:20:40 -0800 (PST)
Received: from gmail.com ([77.124.84.167])
        by smtp.gmail.com with ESMTPSA id u17sm1496764ejr.59.2021.02.03.13.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 13:20:39 -0800 (PST)
Date:   Wed, 3 Feb 2021 23:20:35 +0200
From:   Dan Aloni <dan@kernelim.com>
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Anna Schumaker <schumaker.anna@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] SUNRPC: Create sysfs files for changing IP
Message-ID: <20210203212035.qncen4u3o6pr57h6@gmail.com>
References: <20210202184244.288898-1-Anna.Schumaker@Netapp.com>
 <75F3F315-84AA-41A0-A43A-C531042A9C47@oracle.com>
 <CAFX2JfktYGe4vDtXogFHurdyz4TJx5APj9pb-J5HmsDGC99kaA@mail.gmail.com>
 <20210202192417.ug32gmuc2uciik54@gmail.com>
 <8A686173-B3FF-4122-990C-6E8795D35161@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8A686173-B3FF-4122-990C-6E8795D35161@redhat.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Feb 02, 2021 at 02:49:38PM -0500, Benjamin Coddington wrote:
> On 2 Feb 2021, at 14:24, Dan Aloni wrote:
> > Also, what do you think would be a straightforward way for a userspace
> > program to find what sunrpc client id serves a mountpoint? If we add an
> > ioctl for the mountdir AFAIK it would be the first one that the NFS
> > client supports, so I wonder if there's a better interface that can work
> > for that.
> 
> I'm a fan of adding an ioctl interface for userspace, but I think we'd
> better avoid using NFS itself because it would be nice to someday implement
> an NFS "shutdown" for non-responsive servers, but sending any ioctl to the
> mountpoint could revalidate it, and we'd hang on the GETATTR.

For that, I was looking into using openat2() with the very recently
added RESOLVE_CACHED flag. However from some experimentation I see that it
still sleeps on the unresponsive mount in nfs_weak_revalidate(), and the
latter cannot tell whether LOOKUP_CACHED flag was passed to
d_weak_revalidate().

> Maybe we can figure out a way to expose the superblock via sysfs for each
> mount.

Essentially this is what fspick() syscall lets you do. I imagine that it
can be implemented entirely under fs/nfs, using fsconfig() from under a
FSCONFIG_SET_STRING passing a special string such as
"report-clients-ids", causing a list of sunrpc client IDs to get written
to the fs_context log.

However even with this interface we may still need to verify that the
path lookup that `fspick` does using `user_path_at` is not blocking on
non-responsive NFS mounts.

-- 
Dan Aloni
