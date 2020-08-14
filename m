Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E965244EAD
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Aug 2020 21:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgHNTLC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Aug 2020 15:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgHNTLC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Aug 2020 15:11:02 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1DDC061386
        for <linux-nfs@vger.kernel.org>; Fri, 14 Aug 2020 12:11:01 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id f7so9261374wrw.1
        for <linux-nfs@vger.kernel.org>; Fri, 14 Aug 2020 12:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PRu88AJhldS1lNC0c30yIgBUYGYlLLRszggUHMMkPo8=;
        b=Xs8bs92lB3HwFxqZ5/GwxZYFl0PImsE7MC+giGirkNIuf9u5BX/GLKbzn3ySBgPVus
         R/9pT2EKH+MwJL3XZQbyBGU3E3jzuUDc3Zzp06Gz0aCGEu3uhhjr6FL6/KToEHKihUYj
         VT2Vo4ZK/T1DomTO0OkOpcj0z3HIwwYqLAL0ccqe6Wit+UGlaXqEhNLoPD8YbUqS3UUd
         sn/Vb2xcUK23EFCzQGcv4XTSLrPyxLyVFMsden5cz7m1/K/hRHxgZcK7x2Vzs+Vl91qD
         qeY4mOMIadcygpiGTWubRpBvpEQNwzmYbbIYw3I5ZU45OWVELHYbbcVd2LW7aYqZScsv
         oQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PRu88AJhldS1lNC0c30yIgBUYGYlLLRszggUHMMkPo8=;
        b=e6qEJVNt4asw65IyGpmS+43VsP1o8O30nsckWmNWgAyWBYe36F6QsLLd07DU4oVB2G
         Ni3lI9I7CQz1/cmt5MKfjv52lAk6bf2V1wKJX0+QvoFJ/3od4ZSKsAI+Abiq8YYTsc6w
         tqwpEqNrtD6sCcrZvqsbZpwChit54q0VV+BKFXy4I0BGBO5MW4HgOr7djNUSYpAkg1eG
         8WS/uYqz5r0VqCEr5Z+sgRc2tbRb/M8AhdVfYUJWdErFq6FIYRvPFuwy5woybDzDasYg
         gSf+6KaSly0BjjqO0kfg+EiGg7ALGrZc+Rvh+9cR4JfeeIVupwCBeAtE1ftDMNQYTTyc
         +xtQ==
X-Gm-Message-State: AOAM532ifRq6/bfiF1AvMc244NinttJXv5wrW0EJzUTZODPeQyt70nVN
        dj49GmG1C3pnd//XFufQtki536U9cQw0uw==
X-Google-Smtp-Source: ABdhPJzdi0k25GA/hzgBdCYsuX1cEq85uobtkZq+Bl04RFC42zBj35CJEoPMAjxTSi5RLETkUBxgCg==
X-Received: by 2002:a05:6000:124c:: with SMTP id j12mr3927859wrx.83.1597432260125;
        Fri, 14 Aug 2020 12:11:00 -0700 (PDT)
Received: from gmail.com ([141.226.169.176])
        by smtp.gmail.com with ESMTPSA id o2sm15786868wmh.5.2020.08.14.12.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 12:10:59 -0700 (PDT)
Date:   Fri, 14 Aug 2020 22:10:56 +0300
From:   Dan Aloni <dan@kernelim.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-rdma@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] xprtrdma: make sure MRs are unmapped before freeing them
Message-ID: <20200814191056.GA3277556@gmail.com>
References: <20200814173734.3271600-1-dan@kernelim.com>
 <5B87C3B5-B73D-40FD-A813-B3929CDF7583@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B87C3B5-B73D-40FD-A813-B3929CDF7583@oracle.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Aug 14, 2020 at 02:12:48PM -0400, Chuck Lever wrote:
> Hi Dan-
> 
> > On Aug 14, 2020, at 1:37 PM, Dan Aloni <dan@kernelim.com> wrote:
> > 
> > It was observed that on disconnections, these unmaps don't occur. The
> > relevant path is rpcrdma_mrs_destroy(), being called from
> > rpcrdma_xprt_disconnect().
> 
> MRs are supposed to be unmapped right after they are used, so
> during disconnect they should all be unmapped already. How often
> do you see a DMA mapped MR in this code path? Do you have a
> reproducer I can try?

These are not graceful disconnections but abnormal ones, where many large
IOs are still in flight, while the remote server suddenly breaks the
connection, the remote IP is still reachable but refusing to accept new
connections only for a few seconds.

We may also need reconnection attempts in the background trying to
recover the xprt, so that with short reconnect timeouts it may be enough
for xprt_rdma_close() to be triggered from xprt_rdma_connect_worker(),
leading up to rpcrdma_xprt_disconnect().

-- 
Dan Aloni
