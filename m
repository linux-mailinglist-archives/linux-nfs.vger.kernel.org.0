Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B842433E29
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Oct 2021 20:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbhJSSMk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Oct 2021 14:12:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43503 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234670AbhJSSMk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Oct 2021 14:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634667026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uyH+62IZGe5k3hXewxa7M5XME07XE3dcFv2/Z+R3Ofw=;
        b=g9OuyzqX/fAhNf+bXqI7WvVClJLr2Ykcq5W68Bp1S9UnTWFstrSK4S8CD35XvzetSqLJA4
        G9si5nXKegiLZDy3DPUa7UcGJjX4ttSJHWdV0pTAVMWn7aPBmmCOm/8AEpW4us0oACw0BQ
        Vh1LLdakcTg0ABjGHMKdu/SHHL5jqyo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-SWrNr-L9NPy0ci3V25BjwQ-1; Tue, 19 Oct 2021 14:10:24 -0400
X-MC-Unique: SWrNr-L9NPy0ci3V25BjwQ-1
Received: by mail-qk1-f199.google.com with SMTP id y5-20020ae9f405000000b0045fa3120bebso526476qkl.17
        for <linux-nfs@vger.kernel.org>; Tue, 19 Oct 2021 11:10:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=uyH+62IZGe5k3hXewxa7M5XME07XE3dcFv2/Z+R3Ofw=;
        b=d3imdiUvgIt1rVR6y/Qy6S/I4h/aKYjQz90A/bpyxNNRz39LZHKBxCD7uEGzha+zA9
         i8Jjfk/LRvliB7Wt2nd+ET16r2YsRRqFanRD+TfZU8TIkwQnjfDNUpK6BS7sBRF9uNqv
         AZH4Aqa0tNVSKteBq7S28c06Hwt7CBSoAn1posQqtyX1ottoWaEQfdt97d8C5NOZSEF+
         FlIxQBYuq4ycp1WHsFnu+yROXg7zY689zDnCM8sORSMunSVA0DIHgdVkYdm0ztqrJQW1
         HQhvxzMwmofJV4aqfT2pWVGR2cQpQVYOunXbKe1cymydQB0tthKf7dTixWNbTHxrzRm6
         gzwg==
X-Gm-Message-State: AOAM531I4q/1t+hZbr78fOQlg8cCoe29xiRXhzN0zv4ToIo9jNeFK/8l
        KihG9q7cJflqgUt3zEJklPSrMg9SHa+BFh/VJbYp3r6h2Uw8ZZm+bSMQSDw35AKhOTnwoA9T1VT
        6wWH/iETJt/T6CDtGQ56W
X-Received: by 2002:ac8:5e50:: with SMTP id i16mr1624251qtx.183.1634667023629;
        Tue, 19 Oct 2021 11:10:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJLuZ76jdHw2x6MhcBt3VhM1lWmjSPbiT7VtiIKCx4HQpHVFsAYKQMAnx32ObNTT+eVHMBzg==
X-Received: by 2002:ac8:5e50:: with SMTP id i16mr1624216qtx.183.1634667023452;
        Tue, 19 Oct 2021 11:10:23 -0700 (PDT)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id d23sm7885414qtm.11.2021.10.19.11.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 11:10:21 -0700 (PDT)
Message-ID: <39bc040e9bb88b47f386baa09ed4a508281ce7d6.camel@redhat.com>
Subject: Re: [PATCH 02/67] vfs: Provide S_KERNEL_FILE inode flag
From:   Jeff Layton <jlayton@redhat.com>
To:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 19 Oct 2021 14:10:19 -0400
In-Reply-To: <163456865277.2614702.2064731306330022896.stgit@warthog.procyon.org.uk>
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
         <163456865277.2614702.2064731306330022896.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2021-10-18 at 15:50 +0100, David Howells wrote:
> Provide an S_KERNEL_FILE inode flag that a kernel service, e.g. cachefiles,
> can set to ward off other kernel services and drivers (including itself)
> from using files it is actively using.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  include/linux/fs.h |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e7a633353fd2..197493507744 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2250,6 +2250,7 @@ struct super_operations {
>  #define S_ENCRYPTED	(1 << 14) /* Encrypted file (using fs/crypto/) */
>  #define S_CASEFOLD	(1 << 15) /* Casefolded file */
>  #define S_VERITY	(1 << 16) /* Verity file (using fs/verity/) */
> +#define S_KERNEL_FILE	(1 << 17) /* File is in use by the kernel (eg. fs/cachefiles) */
>  
>  /*
>   * Note that nosuid etc flags are inode-specific: setting some file-system
> 
> 

It'd be better to fold this in with the patch where the first user is
added. That would make it easier to see how you intend to use it.
-- 
Jeff Layton <jlayton@redhat.com>

