Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505E84743A3
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Dec 2021 14:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234484AbhLNNiq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Dec 2021 08:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234479AbhLNNiq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Dec 2021 08:38:46 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C82C06173F
        for <linux-nfs@vger.kernel.org>; Tue, 14 Dec 2021 05:38:45 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id q14so18311537qtx.10
        for <linux-nfs@vger.kernel.org>; Tue, 14 Dec 2021 05:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PYw3dTNxx1w6/rYOsPCI3bE5Vdi4GI8AS7An95Gx17o=;
        b=tUe3gF9yl7uvFOGJXnZDGunLrwNeHUsuozlge/NZ0esl2wmx+9OuT9twoBCrogJXHR
         U+wazLt8k85qXcdVdlEr2QiWsHWjffFixl9JczbvlcYNtmeYAEmWFswwvrf2w87ZZrvq
         WrBqfJpvjakwAHIhRNOhg18W8LuPvroIdKQoOQRnU++rANlMZ6I+El/IZfP6vNfWdiK8
         G8BcYPbMdTezYk0AYApyD6ptaX+f18/ftVFujPLH6n561NNxDfTrp22U3edtVm0zJLLY
         M4kfHx2yE/xcYoqfmDuL+bzlIOAfap6ttSGzkp6IZ6XE2t7BnJ//QLefREQAx5CEcwRp
         97+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PYw3dTNxx1w6/rYOsPCI3bE5Vdi4GI8AS7An95Gx17o=;
        b=i/nbYaaWyxt6eIpe1S6EFqKpb4JbnUjmxZBJBFO6WJiY0mhFE5QgJlW+Cl2NtR9sc9
         zC7q0RHqWqc2IBzgHaenlZggN7DWv9aqblMiEdIK8bDc9m34CZf1KhWk4cvro7dRyV6l
         aVjR7FfVOPfhP1tD6B9GgpScqN+w0mtlaodC/cS46n8R/xTNNjt3eAdHz9Ewx4GgjNbZ
         8OX8a7Z8d0LGy56gftEAosa6iNiReQIxtE+FX9ecwHVKQr08l9qiUNgAddgb5Q+50SUK
         e36+O5Q17CjzOTGdP1veP5Iuq0FUWJy7rEJ03EZbwH80Fknx152L1KM6aJlLyQBVM2sF
         LY4A==
X-Gm-Message-State: AOAM5334rV23jVQ969/fwVoXxmI+4ziDGoACpXpGUjTALP5BD2UVt4Lu
        KBfr3Yzf/MCOKbIL46esC/74XQ==
X-Google-Smtp-Source: ABdhPJwe1RWdhQKAzec7IHklUmwTSxvNcuVGOWbGkmTG1+fmiDw0JM0mWzPgit/4twx8SXN+ZSxh3Q==
X-Received: by 2002:ac8:5ccd:: with SMTP id s13mr5995548qta.510.1639489125026;
        Tue, 14 Dec 2021 05:38:45 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:e1e4])
        by smtp.gmail.com with ESMTPSA id ay42sm7612729qkb.40.2021.12.14.05.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 05:38:44 -0800 (PST)
Date:   Tue, 14 Dec 2021 14:38:39 +0100
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     willy@infradead.org, akpm@linux-foundation.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, shakeelb@google.com, guro@fb.com,
        shy828301@gmail.com, alexs@kernel.org, richard.weiyang@gmail.com,
        david@fromorbit.com, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, jaegeuk@kernel.org, chao@kernel.org,
        kari.argillander@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, zhengqi.arch@bytedance.com,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        smuchun@gmail.com
Subject: Re: [PATCH v4 01/17] mm: list_lru: optimize memory consumption of
 arrays of per cgroup lists
Message-ID: <YbieX3WCUt7hdZlW@cmpxchg.org>
References: <20211213165342.74704-1-songmuchun@bytedance.com>
 <20211213165342.74704-2-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213165342.74704-2-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Dec 14, 2021 at 12:53:26AM +0800, Muchun Song wrote:
> The list_lru uses an array (list_lru_memcg->lru) to store pointers
> which point to the list_lru_one. And the array is per memcg per node.
> Therefore, the size of the arrays will be 10K * number_of_node * 8 (
> a pointer size on 64 bits system) when we run 10k containers in the
> system. The memory consumption of the arrays becomes significant. The
> more numa node, the more memory it consumes.

The complexity for the lists themselves is still nrmemcgs * nrnodes
right? But the rcu_head goes from that to nrmemcgs.

> I have done a simple test, which creates 10K memcg and mount point
> each in a two-node system. The memory consumption of the list_lru
> will be 24464MB. After converting the array from per memcg per node
> to per memcg, the memory consumption is going to be 21957MB. It is
> reduces by 2.5GB. In our AMD servers, there are 8 numa nodes in
> those system, the memory consumption could be more significant.

The code looks good to me, but it would be useful to include a
high-level overview of the new scheme, explain that the savings come
from the rcu heads, that it simplifies the alloc/dealloc path etc.

With that,

> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
