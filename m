Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5F119F3E8
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Apr 2020 12:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgDFK52 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Apr 2020 06:57:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36378 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgDFK52 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Apr 2020 06:57:28 -0400
Received: by mail-wm1-f65.google.com with SMTP id d202so15339990wmd.1;
        Mon, 06 Apr 2020 03:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g5mY/6j+QCbr50e5xP/QNFLfFi9SvIAJHD7FGYbPvOI=;
        b=epdGNnlRAHhd8nG5XjmSks0ueQkDVxN+tk76w/WK4rdFEiMDcWsZ1KhqSszzqqK6ME
         ijoDDhSVr7sqVyVc7tq2zoeL0XZRyhZepYsQRATkj7EFaAo3r2gQpZhRFSUbwfa/6S5t
         Yuzbe+TSHV20V3ZQMF2+L+l9UeItgFdenwb0/2hu1KLZyNMGeGRuGNXaLxbouYxCmP2k
         BuS2iaHuCDL8fgOU9nqnOiDhZZY6AIhF+Q/HCikTJ4H4s0qZ0j4d1PU+ExxMWmdwdrjv
         2+0GqiLWrgWoXZPnt567wYp19+7duZQxjrcEGUNW5XuqowIIYwmBJqB5osX3L81jHyID
         /4cg==
X-Gm-Message-State: AGi0PuaY8dfXz7oekAtUQIHD5yZ128odoymlfKPzset/Tef5wqsFJJ+F
        iH10wV+0uI7E/LIOi7PtWDE=
X-Google-Smtp-Source: APiQypLI2VKCrb+awtZriktURlgTQ9LBJ2jKntQWFaLBR48f6AeEwpIjCggmXhacyVJA38rFQc9SrA==
X-Received: by 2002:a7b:cb13:: with SMTP id u19mr4747173wmj.132.1586170645555;
        Mon, 06 Apr 2020 03:57:25 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id a2sm17369883wra.71.2020.04.06.03.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 03:57:24 -0700 (PDT)
Date:   Mon, 6 Apr 2020 12:57:23 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     NeilBrown <neilb@suse.de>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "Anna.Schumaker@Netapp.com" <Anna.Schumaker@netapp.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] MM: replace PF_LESS_THROTTLE with PF_LOCAL_THROTTLE
Message-ID: <20200406105723.GM19426@dhcp22.suse.cz>
References: <87tv2b7q72.fsf@notabene.neil.brown.name>
 <87v9miydai.fsf@notabene.neil.brown.name>
 <87sghmyd8v.fsf@notabene.neil.brown.name>
 <20200403151534.GG22681@dhcp22.suse.cz>
 <878sjcxn7i.fsf@notabene.neil.brown.name>
 <20200406074453.GH19426@dhcp22.suse.cz>
 <20200406093601.GA1143@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406093601.GA1143@quack2.suse.cz>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon 06-04-20 11:36:01, Jan Kara wrote:
> On Mon 06-04-20 09:44:53, Michal Hocko wrote:
> > On Sat 04-04-20 08:40:17, Neil Brown wrote:
> > > On Fri, Apr 03 2020, Michal Hocko wrote:
> > > 
> > > > On Thu 02-04-20 10:53:20, Neil Brown wrote:
> > > >> 
> > > >> PF_LESS_THROTTLE exists for loop-back nfsd, and a similar need in the
> > > >> loop block driver, where a daemon needs to write to one bdi in
> > > >> order to free up writes queued to another bdi.
> > > >> 
> > > >> The daemon sets PF_LESS_THROTTLE and gets a larger allowance of dirty
> > > >> pages, so that it can still dirty pages after other processses have been
> > > >> throttled.
> > > >> 
> > > >> This approach was designed when all threads were blocked equally,
> > > >> independently on which device they were writing to, or how fast it was.
> > > >> Since that time the writeback algorithm has changed substantially with
> > > >> different threads getting different allowances based on non-trivial
> > > >> heuristics.  This means the simple "add 25%" heuristic is no longer
> > > >> reliable.
> > > >> 
> > > >> This patch changes the heuristic to ignore the global limits and
> > > >> consider only the limit relevant to the bdi being written to.  This
> > > >> approach is already available for BDI_CAP_STRICTLIMIT users (fuse) and
> > > >> should not introduce surprises.  This has the desired result of
> > > >> protecting the task from the consequences of large amounts of dirty data
> > > >> queued for other devices.
> > > >
> > > > While I understand that you want to have per bdi throttling for those
> > > > "special" files I am still missing how this is going to provide the
> > > > additional room that the additnal 25% gave them previously. I might
> > > > misremember or things have changed (what you mention as non-trivial
> > > > heuristics) but PF_LESS_THROTTLE really needed that room to guarantee a
> > > > forward progress. Care to expan some more on how this is handled now?
> > > > Maybe we do not need it anymore but calling that out explicitly would be
> > > > really helpful.
> > > 
> > > The 25% was a means to an end, not an end in itself.
> > > 
> > > The problem is that the NFS server needs to be able to write to the
> > > backing filesystem when the dirty memory limits have been reached by
> > > being totally consumed by dirty pages on the NFS filesystem.
> > > 
> > > The 25% was just a way of giving an allowance of dirty pages to nfsd
> > > that could not be consumed by processes writing to an NFS filesystem.
> > > i.e. it doesn't need 25% MORE, it needs 25% PRIVATELY.  Actually it only
> > > really needs 1 page privately, but a few pages give better throughput
> > > and 25% seemed like a good idea at the time.
> > 
> > Yes this part is clear to me.
> >  
> > > per-bdi throttling focuses on the "PRIVATELY" (the important bit) and
> > > de-emphasises the 25% (the irrelevant detail).
> > 
> > It is still not clear to me how this patch is going to behave when the
> > global dirty throttling is essentially equal to the per-bdi - e.g. there
> > is only a single bdi and now the PF_LOCAL_THROTTLE process doesn't have
> > anything private.
> 
> Let me think out loud so see whether I understand this properly. There are
> two BDIs involved in NFS loop mount - the NFS virtual BDI (let's call it
> simply NFS-bdi) and the bdi of the real filesystem that is backing NFS
> (let's call this real-bdi). The case we are concerned about is when NFS-bdi
> is full of dirty pages so that global dirty limit of the machine is
> exceeded. Then flusher thread will take dirty pages from NFS-bdi and send
> them over localhost to nfsd. Nfsd, which has PF_LOCAL_THROTTLE set, will take
> these pages and write them to real-bdi. Now because PF_LOCAL_THROTTLE is
> set for nfsd, the fact that we are over global limit does not take effect
> and nfsd is still able to write to real-bdi until dirty limit on real-bdi
> is reached. So things should work as Neil writes AFAIU.

Thanks for the clarification. I was not aware of the 2 bdi situation.
This makes more sense now. Maybe this is a trivial fact for everybody
who is more familiar with nfs internals but it would be so much esier to
follow if it was explicit in the changelog.
-- 
Michal Hocko
SUSE Labs
