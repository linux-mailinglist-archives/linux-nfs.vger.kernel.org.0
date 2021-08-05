Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEB73E1D2A
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Aug 2021 22:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhHEULj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Aug 2021 16:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbhHEULj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Aug 2021 16:11:39 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5EDC061765
        for <linux-nfs@vger.kernel.org>; Thu,  5 Aug 2021 13:11:24 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so12309789pjh.3
        for <linux-nfs@vger.kernel.org>; Thu, 05 Aug 2021 13:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+xS0rNCbWcHnzm6yhSIJwEdxrGyiUrUKRfpnM0ZXn1Y=;
        b=ubstJrMI4ocbkAcB0Y068u3MLZh8hPKdA33BMB+YuSF7BJtMffh6HhRESClQMI2bwC
         qNtYXLKWl+LpqCSL+9jBkVBme+COPvft48vW42ELz4f5/Qml2QwSOW0mlkqbjjCC+xBg
         OV67317fw9+5Ea9wvZ2NTnkiJJzYiYJAJjVc7mTSqyrBWCFZz0AfOi3BtWy7sCdAdP32
         oJE3MLuCXsAKssr0yChO1ha3clDhuib0AZKbkZBCRIorscjfp4gobmzGFlxTGBJ761Mv
         uC1ga6mH9cZJ7ZzVujcI0/APRkKdg7bwJY1ERT7BFTNXTSWXBFUHjrnTxsl3UzXBAOqt
         Dmwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+xS0rNCbWcHnzm6yhSIJwEdxrGyiUrUKRfpnM0ZXn1Y=;
        b=mvDy36QfRTjZYp0s9xGNHdDBUHKHhRtgHQz9Swglt/flq2lIPGIMT1E2a5BQGky+6V
         9+jdxmX0zkboye6fM4c02RIugJXl5XgUW9GBc5Idyi5aO7nruuShKCjiOWBLI5iZ9j1m
         yn7L/i2XLOWaJQqcCBttC9YxcAqTHqOva6jdOK6lRc0gHMm1c6kSBdqnpLLhUXE6fZAw
         WvUwBZoefFJkIypeGkWW3sQNOFcK8uz2I7gKVghEakcOSxK+kvAsU4MOv87tjVJFfAQn
         egnhpsoaKFeR2GDujh4gsY3gucRzTcLv9Hm3cvJH8ex543MysPXC37uuxaYokRhQ9CEJ
         b94A==
X-Gm-Message-State: AOAM53075ICWhlrgVLjqxZ0gWWKJPjtN+r1PRo9752o0b0WZf4YuKd2i
        B7VTO238qbEHkKAfU/VDk1hUrQgB+YM=
X-Google-Smtp-Source: ABdhPJzJ7Me5FVKLD/ScSBqNsnQrymGS385aM/ElPhCoTnkxWdZStLBw5wu3gBs+YGL3BZYhHtbKsw==
X-Received: by 2002:a17:90a:4e4e:: with SMTP id t14mr6526951pjl.8.1628194284487;
        Thu, 05 Aug 2021 13:11:24 -0700 (PDT)
Received: from nyarly.rlyeh.local ([179.233.244.167])
        by smtp.gmail.com with ESMTPSA id w18sm7407934pjg.50.2021.08.05.13.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 13:11:23 -0700 (PDT)
Date:   Thu, 5 Aug 2021 17:11:19 -0300
From:   Thiago Rafael Becker <trbecker@gmail.com>
To:     Steve Dickson <steved@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "tbecker@redhat.com" <tbecker@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [RFC PATCH] mount.nfs: Add readahead option
Message-ID: <YQxF59HvoJzQZVaM@nyarly.rlyeh.local>
References: <20210803130717.2890565-1-trbecker@gmail.com>
 <6b627dc6ebc9ee1cbd37a62b48d08b1a031f0f08.camel@hammerspace.com>
 <b1f88c47-fe08-f0a2-ad3e-a65e0fa86874@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1f88c47-fe08-f0a2-ad3e-a65e0fa86874@redhat.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello, all

On Thu, Aug 05, 2021 at 02:23:29PM -0400, Steve Dickson wrote:
> Hey Trond!
> but setting a mount option is much simpler and straightforward...
> Plus with nfsmount.conf, it can be per fs,server,or global.
> 
> You know I am not a fan of taking new mount options, but I have
> bugs open that show the degrading of read performance from one
> release over another... If we can eliminate that degradation with an mount
> option... I really don't see a problem with that...
> 
> steved.
> 

CEPH and CIFS have the rasize mount option that sets the readahead
size for that file system, so there are precedents for having this
option for NFS as well.
