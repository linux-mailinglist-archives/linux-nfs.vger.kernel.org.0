Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C49B8166628
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2020 19:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgBTSZy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Feb 2020 13:25:54 -0500
Received: from mail-il1-f171.google.com ([209.85.166.171]:36517 "EHLO
        mail-il1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgBTSZy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Feb 2020 13:25:54 -0500
Received: by mail-il1-f171.google.com with SMTP id b15so24493366iln.3
        for <linux-nfs@vger.kernel.org>; Thu, 20 Feb 2020 10:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=62O4Txk9c9tJW4y5S3XR+/4amEOBQLxgREdm3XLgXdU=;
        b=mWnbwg9+cFFJyEZmy2jZLmVMd/I+f2ye/gA5T0P4J07a9qUSFnIhtBs4kZ3tm2K8Y+
         xjslglPbW3OdAkxQO9i1XBLilehn7hMHgRy2nb7jEnRN+y3YmrNxxTqWv0aeZkbywyaC
         iUqexqakfBMCK+xHGfj7ojpinBTdaLMNSdYO3DT7RsRHyfViLfkj8m7PQbnpH225Dv0p
         ZBztKfK2pIDErO9Tc7WtlVhwSKLP0YPt+vhw3A2quD7e/1S4CSsvQcOH5eHWlrWrkyXO
         CzGWbhjeYMCjBSSP4QBB+Lh73EvClFaWlPoWlApJNyr6vkhqQXiCRZOKRp4UPsbLq8u6
         58Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:message-id:subject:from:to:cc:date
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=62O4Txk9c9tJW4y5S3XR+/4amEOBQLxgREdm3XLgXdU=;
        b=BuCKhRblktesgKWyRhz+LsmXeLW57W5dfsurvZf5PtM056u55oWF+7iSJ7pcJ8/4I1
         XVf1Ifj5iikvDyxRuHQpOc5VXePfE/ZjrfjmU8xOzpcDDhM2IotW8/M9Z0leDa2XgusO
         rCWCScZqx2ueL6iiYdUzJQ2FD9QggcIWcv024t9gUTT7x/5c096Bd456Vhf06+fSXz5p
         25vTPP658aE2B7QmKLRdpfwWSRHWPZeGyyFwsh4jq7QUTUslK1wuBnJn+U0peA4EWYmf
         SthIKbAI2e1vYHlFa2TH+Hg6m5omaMnQf/1kqZVChDPQJvQ19a8FhKchPz5mSBd+yNfr
         THQA==
X-Gm-Message-State: APjAAAVbhBuOo8uRBiK37Oo5nUHSkaA2e72ZWph26U/6usXtMFP0BHAt
        NBebgdbwEn4M+olNY8/fX1E=
X-Google-Smtp-Source: APXvYqzYNdO54qVQGT/dLS7KYCgdX25r0Yd6Me+rRSlU6HsXBR5gqcgGllMwE8YIboHFZeF7gR7lJA==
X-Received: by 2002:a92:afc5:: with SMTP id v66mr28576557ill.123.1582223151855;
        Thu, 20 Feb 2020 10:25:51 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.googlemail.com with ESMTPSA id z15sm52954ill.20.2020.02.20.10.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 10:25:51 -0800 (PST)
Message-ID: <c20cd5a113d19b8287bcc3db9c1b594ecb0e61e4.camel@gmail.com>
Subject: Re: [PATCH v2 0/6] NFS: Add support for the v4.2 READ_PLUS operation
From:   Anna Schumaker <schumaker.anna@gmail.com>
To:     Chuck Lever <chucklever@gmail.com>
Cc:     Trond.Myklebust@hammerspace.com,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Thu, 20 Feb 2020 13:25:50 -0500
In-Reply-To: <34F6A8B4-3BC0-4C29-A6C1-176D3A866BFD@gmail.com>
References: <20200214211227.407836-1-Anna.Schumaker@Netapp.com>
         <34F6A8B4-3BC0-4C29-A6C1-176D3A866BFD@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2020-02-20 at 12:40 -0500, Chuck Lever wrote:
> Hi Anna-
> 
> > On Feb 14, 2020, at 4:12 PM, schumaker.anna@gmail.com wrote:
> > 
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > 
> > These patches add client support for the READ_PLUS operation, which
> > breaks read requests into several "data" and "hole" segments when
> > replying to the client. I also add a "noreadplus" mount option to allow
> > users to disable the new operation if it becomes a problem, similar to
> > the "nordirplus" mount option that we already have.
> 
> Hrm, I went looking for the patch that adds "noreadplus", but I
> don't see it in this series?

You suggested dropping that patch in the v1 posting and waiting to see if
anybody asks for it.

> 
> Wondering if, to start off, the default should be "noreadplus"
> until our feet are under us. Just a thought.

I could re-add the patch with this as the default if that's the way everybody
wants to go.

Anna

> 
> 
> > Here are the results of some performance tests I ran on Netapp lab
> > machines. I tested by reading various 2G files from a few different
> > undelying filesystems and across several NFS versions. I used the
> > `vmtouch` utility to make sure files were only cached when we wanted
> > them to be. In addition to 100% data and 100% hole cases, I also tested
> > with files that alternate between data and hole segments. These files
> > have either 4K, 8K, 16K, or 32K segment sizes and start with either data
> > or hole segments. So the file mixed-4d has a 4K segment size beginning
> > with a data segment, but mixed-32h hase 32K segments beginning with a
> > hole. The units are in seconds, with the first number for each NFS
> > version being the uncached read time and the second number is for when
> > the file is cached on the server.
> > 
> > ext4      |        v3       |       v4.0      |       v4.1      |       v4.2
> >       |
> > ----------|-----------------|-----------------|-----------------|-----------
> > ------|
> > data      | 22.909 : 18.253 | 22.934 : 18.252 | 22.902 : 18.253 | 23.485 :
> > 18.253 |
> > hole      | 18.256 : 18.253 | 18.255 : 18.252 | 18.256 : 18.253 |  0.708
> > :  0.709 |
> > mixed-4d  | 28.261 : 18.253 | 29.616 : 18.252 | 28.341 : 18.252 | 24.508
> > :  9.150 |
> > mixed-8d  | 27.956 : 18.253 | 28.404 : 18.252 | 28.320 : 18.252 | 23.967
> > :  9.140 |
> > mixed-16d | 28.172 : 18.253 | 27.946 : 18.252 | 27.627 : 18.252 | 23.043
> > :  9.134 |
> > mixed-32d | 25.350 : 18.253 | 24.406 : 18.252 | 24.384 : 18.253 | 20.698
> > :  9.132 |
> > mixed-4h  | 28.913 : 18.253 | 28.564 : 18.252 | 27.996 : 18.252 | 21.837
> > :  9.150 |
> > mixed-8h  | 28.625 : 18.253 | 27.833 : 18.252 | 27.798 : 18.253 | 21.710
> > :  9.140 |
> > mixed-16h | 27.975 : 18.253 | 27.662 : 18.252 | 27.795 : 18.253 | 20.585
> > :  9.134 |
> > mixed-32h | 25.958 : 18.253 | 25.491 : 18.252 | 24.856 : 18.252 | 21.018
> > :  9.132 |
> > 
> > xfs       |        v3       |       v4.0      |       v4.1      |       v4.2
> >       |
> > ----------|-----------------|-----------------|-----------------|-----------
> > ------|
> > data      | 22.041 : 18.253 | 22.618 : 18.252 | 23.067 : 18.253 | 23.496 :
> > 18.253 |
> > hole      | 18.256 : 18.253 | 18.255 : 18.252 | 18.256 : 18.253 |  0.723
> > :  0.708 |
> > mixed-4d  | 29.417 : 18.253 | 28.503 : 18.252 | 28.671 : 18.253 | 24.957
> > :  9.150 |
> > mixed-8d  | 29.080 : 18.253 | 29.401 : 18.252 | 29.251 : 18.252 | 24.625
> > :  9.140 |
> > mixed-16d | 27.638 : 18.253 | 28.606 : 18.252 | 27.871 : 18.253 | 25.511
> > :  9.135 |
> > mixed-32d | 24.967 : 18.253 | 25.239 : 18.252 | 25.434 : 18.252 | 21.728
> > :  9.132 |
> > mixed-4h  | 34.816 : 18.253 | 36.243 : 18.252 | 35.837 : 18.252 | 32.332
> > :  9.150 |
> > mixed-8h  | 43.469 : 18.253 | 44.009 : 18.252 | 43.810 : 18.253 | 37.962
> > :  9.140 |
> > mixed-16h | 29.280 : 18.253 | 28.563 : 18.252 | 28.241 : 18.252 | 22.116
> > :  9.134 |
> > mixed-32h | 29.428 : 18.253 | 29.378 : 18.252 | 28.808 : 18.253 | 27.378
> > :  9.134 |
> > 
> > btrfs     |        v3       |       v4.0      |       v4.1      |       v4.2
> >       |
> > ----------|-----------------|-----------------|-----------------|-----------
> > ------|
> > data      | 25.547 : 18.253 | 25.053 : 18.252 | 24.209 : 18.253 | 32.121 :
> > 18.253 |
> > hole      | 18.256 : 18.253 | 18.255 : 18.252 | 18.256 : 18.252 |  0.702
> > :  0.724 |
> > mixed-4d  | 19.016 : 18.253 | 18.822 : 18.252 | 18.955 : 18.253 | 18.697
> > :  9.150 |
> > mixed-8d  | 19.186 : 18.253 | 19.444 : 18.252 | 18.841 : 18.253 | 18.452
> > :  9.140 |
> > mixed-16d | 18.480 : 18.253 | 19.010 : 18.252 | 19.167 : 18.252 | 16.000
> > :  9.134 |
> > mixed-32d | 18.635 : 18.253 | 18.565 : 18.252 | 18.550 : 18.252 | 15.930
> > :  9.132 |
> > mixed-4h  | 19.079 : 18.253 | 18.990 : 18.252 | 19.157 : 18.253 | 27.834
> > :  9.150 |
> > mixed-8h  | 18.613 : 18.253 | 19.234 : 18.252 | 18.616 : 18.253 | 20.177
> > :  9.140 |
> > mixed-16h | 18.590 : 18.253 | 19.221 : 18.252 | 19.654 : 18.253 | 17.273
> > :  9.135 |
> > mixed-32h | 18.768 : 18.253 | 19.122 : 18.252 | 18.535 : 18.252 | 15.791
> > :  9.132 |
> > 
> > ext3      |        v3       |       v4.0      |       v4.1      |       v4.2
> >       |
> > ----------|-----------------|-----------------|-----------------|-----------
> > ------|
> > data      | 34.292 : 18.253 | 33.810 : 18.252 | 33.450 : 18.253 | 33.390 :
> > 18.254 |
> > hole      | 18.256 : 18.253 | 18.255 : 18.252 | 18.256 : 18.253 |  0.718
> > :  0.728 |
> > mixed-4d  | 46.818 : 18.253 | 47.140 : 18.252 | 48.385 : 18.253 | 42.887
> > :  9.150 |
> > mixed-8d  | 58.554 : 18.253 | 59.277 : 18.252 | 59.673 : 18.253 | 56.760
> > :  9.140 |
> > mixed-16d | 44.631 : 18.253 | 44.291 : 18.252 | 44.729 : 18.253 | 40.237
> > :  9.135 |
> > mixed-32d | 39.110 : 18.253 | 38.735 : 18.252 | 38.902 : 18.252 | 35.270
> > :  9.132 |
> > mixed-4h  | 56.396 : 18.253 | 56.387 : 18.252 | 56.573 : 18.253 | 67.661
> > :  9.150 |
> > mixed-8h  | 58.483 : 18.253 | 58.484 : 18.252 | 59.099 : 18.253 | 77.958
> > :  9.140 |
> > mixed-16h | 42.511 : 18.253 | 42.338 : 18.252 | 42.356 : 18.252 | 51.805
> > :  9.135 |
> > mixed-32h | 38.419 : 18.253 | 38.504 : 18.252 | 38.643 : 18.252 | 40.411
> > :  9.132 |
> > 
> > 
> > Changes since v1:
> > - Rebase to 5.6-rc1
> > - Drop the mount option patch for now
> > - Fix fallback to READ when the server doesn't support READ_PLUS
> > 
> > Any questions?
> > Anna
> > 
> > 
> > Anna Schumaker (6):
> >  SUNRPC: Split out a function for setting current page
> >  SUNRPC: Add the ability to expand holes in data pages
> >  SUNRPC: Add the ability to shift data to a specific offset
> >  NFS: Add READ_PLUS data segment support
> >  NFS: Add READ_PLUS hole segment decoding
> >  NFS: Decode multiple READ_PLUS segments
> > 
> > fs/nfs/nfs42xdr.c          | 169 +++++++++++++++++++++++++
> > fs/nfs/nfs4proc.c          |  43 ++++++-
> > fs/nfs/nfs4xdr.c           |   1 +
> > include/linux/nfs4.h       |   2 +-
> > include/linux/nfs_fs_sb.h  |   1 +
> > include/linux/nfs_xdr.h    |   2 +-
> > include/linux/sunrpc/xdr.h |   2 +
> > net/sunrpc/xdr.c           | 244 ++++++++++++++++++++++++++++++++++++-
> > 8 files changed, 457 insertions(+), 7 deletions(-)
> > 
> > -- 
> > 2.25.0
> > 
> 
> --
> Chuck Lever
> chucklever@gmail.com
> 
> 
> 

