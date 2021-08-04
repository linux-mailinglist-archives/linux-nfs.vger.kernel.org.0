Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31563E0663
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Aug 2021 19:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239793AbhHDROQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Aug 2021 13:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239695AbhHDROQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Aug 2021 13:14:16 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAE6C0613D5
        for <linux-nfs@vger.kernel.org>; Wed,  4 Aug 2021 10:14:02 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id z3so3697612plg.8
        for <linux-nfs@vger.kernel.org>; Wed, 04 Aug 2021 10:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WIXr6iFNMcCaiUA+Z5JVlQf134eZgEHptHFpQyVcMnM=;
        b=cffQLeYXs0+24iGfCDYTk5BJactqXTmawIf0vxBw8gM2WO96BjE803r0i4jVNbe0sI
         YbslLfmEzQjSt8KaLmZeK3D6Y/NYSEtkqN7BvkGRbiK9o+1OaGyZzJhaZtYv7TqE8pIV
         rvnqaemVTNLlbOIcJA6rjeBIlOzgGzO58DGqzfhCeMlqb23D1IpsUTQInyt4uhvxyVP8
         JKCaIx6jC79doK3lWb7Fb8SEbtsI9MNPbXE4ZoKuzmr3zi9x4bNK1biPgsZWJAUi75Ml
         XozpGfZydniQ61CQ5CAzcK0d+FFJDyV8NuHZtjY2uLGJYBl2afAg+FlA203+azMIEeqU
         Z/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WIXr6iFNMcCaiUA+Z5JVlQf134eZgEHptHFpQyVcMnM=;
        b=Lk2fm0wRJrjBUCewc0wXvdnBQdurGNuUBDrCdrWjSZEH3EwIo943rOrKw0Z4+Eh8jY
         AghnCUTPeU+X0JmaQ+fbDi8TXXZet+mOwttz36q63KVY5+GSZXH1lBdgJs8Wzlryx7Qh
         X1T0xpT+hZrmxAjk2taw5ys9RN61WEsKldw9ilhvlPxtp7n2DUDGBmeGxLfbCHtEGgM2
         bZqBvhopUB+A1oB8i+IBFMc4isAko2fgLWBTe0qM5TsvoYODKXZUqkvsNgs3UqIoiN0h
         E1RCa2ja1yJs/V1ECvZti+bsbnjmj0z8hGqLhyS8RifbM+hMmwjIei32jP07sN5rHVVg
         A98g==
X-Gm-Message-State: AOAM532JUcXdZmZU5sQXz4734Q3leTrs+uXTuC0F8I0k8XsDGCHBxKJv
        u1HVlu2iGc6e+LSNXo45F+xNzva6mLU=
X-Google-Smtp-Source: ABdhPJwv1MHA4JQpDPhuyRHN8adWFbQYd84f0UR6v3nQFy4IV1Odfa7erZyw3rVyzAOYavIGMzYtFQ==
X-Received: by 2002:aa7:8c56:0:b029:3c2:ca37:800 with SMTP id e22-20020aa78c560000b02903c2ca370800mr592014pfd.54.1628097241829;
        Wed, 04 Aug 2021 10:14:01 -0700 (PDT)
Received: from nyarly.rlyeh.local ([179.233.244.167])
        by smtp.gmail.com with ESMTPSA id b26sm3634489pfo.47.2021.08.04.10.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 10:14:01 -0700 (PDT)
Date:   Wed, 4 Aug 2021 14:13:55 -0300
From:   Thiago Rafael Becker <trbecker@gmail.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "steved@redhat.com" <steved@redhat.com>,
        "tbecker@redhat.com" <tbecker@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [RFC PATCH] mount.nfs: Add readahead option
Message-ID: <YQrK09dj3cjJoTLk@nyarly.rlyeh.local>
References: <20210803130717.2890565-1-trbecker@gmail.com>
 <6b627dc6ebc9ee1cbd37a62b48d08b1a031f0f08.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b627dc6ebc9ee1cbd37a62b48d08b1a031f0f08.camel@hammerspace.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Aug 03, 2021 at 03:15:54PM +0000, Trond Myklebust wrote:
> There is already a method for doing this: you set up an appropriate
> entry in /etc/udev/rules.d/. Adding a mount option, particularly one
> that is NFS only and is handled in userspace rather than by the kernel
> parser, just causes fragmentation and confusion.
> 
> If you want to help users configure readahead, I'd suggest focussing on
> a utility to help them set up the udev rule correctly.

I prototyped a tool that runs on udev when a new bdi is added, you can
see it at https://github.com/trbecker/readahead-utils. If this is good
enough, it can have a user friendly tool that can be used to set the
read ahead, check current values and manipulate the configuration file.

I have a few limitations I see in this approach.

This creates a different place to look into when debugging systems.
Having the mount options would be more "in the face" of the engineer
doing the debugging.

This complicates configurations on clusters, and I find having the
option better.

I'm not sure how this would interact with containers, if this would
create issues between the container and the host system.

Advantages of this approach are the possibility to have defaults by fs
type, device type, server (in case of a networked filesysem), wildcards.
Some are good because they allow the user to improve memory usage
(reducing the readahead for random access devices, increasing it for
spinning devices and network devices, ...), some allow a set and forget
configuration for directories that are used for hosting filesystems
(automount, container directories, ...), which can't be achieved by a
mount option.

I agree with the fragmentation. Having this go into the kernel parser as
a mount option seems to be a better way. Again, this is more granular
and easier to find than having a separate application that runs on udev.

I want opinions on these different approaches.

Best,
Thiago
