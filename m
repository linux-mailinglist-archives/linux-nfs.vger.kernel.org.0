Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8297A19F2AC
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Apr 2020 11:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgDFJgH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Apr 2020 05:36:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:51342 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbgDFJgH (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 6 Apr 2020 05:36:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6BA0FAE71;
        Mon,  6 Apr 2020 09:36:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 671AA1E1244; Mon,  6 Apr 2020 11:36:01 +0200 (CEST)
Date:   Mon, 6 Apr 2020 11:36:01 +0200
From:   Jan Kara <jack@suse.cz>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     NeilBrown <neilb@suse.de>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "Anna.Schumaker@Netapp.com" <Anna.Schumaker@netapp.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] MM: replace PF_LESS_THROTTLE with PF_LOCAL_THROTTLE
Message-ID: <20200406093601.GA1143@quack2.suse.cz>
References: <87tv2b7q72.fsf@notabene.neil.brown.name>
 <87v9miydai.fsf@notabene.neil.brown.name>
 <87sghmyd8v.fsf@notabene.neil.brown.name>
 <20200403151534.GG22681@dhcp22.suse.cz>
 <878sjcxn7i.fsf@notabene.neil.brown.name>
 <20200406074453.GH19426@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406074453.GH19426@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon 06-04-20 09:44:53, Michal Hocko wrote:
> On Sat 04-04-20 08:40:17, Neil Brown wrote:
> > On Fri, Apr 03 2020, Michal Hocko wrote:
> > 
> > > On Thu 02-04-20 10:53:20, Neil Brown wrote:
> > >> 
> > >> PF_LESS_THROTTLE exists for loop-back nfsd, and a similar need in the
> > >> loop block driver, where a daemon needs to write to one bdi in
> > >> order to free up writes queued to another bdi.
> > >> 
> > >> The daemon sets PF_LESS_THROTTLE and gets a larger allowance of dirty
> > >> pages, so that it can still dirty pages after other processses have been
> > >> throttled.
> > >> 
> > >> This approach was designed when all threads were blocked equally,
> > >> independently on which device they were writing to, or how fast it was.
> > >> Since that time the writeback algorithm has changed substantially with
> > >> different threads getting different allowances based on non-trivial
> > >> heuristics.  This means the simple "add 25%" heuristic is no longer
> > >> reliable.
> > >> 
> > >> This patch changes the heuristic to ignore the global limits and
> > >> consider only the limit relevant to the bdi being written to.  This
> > >> approach is already available for BDI_CAP_STRICTLIMIT users (fuse) and
> > >> should not introduce surprises.  This has the desired result of
> > >> protecting the task from the consequences of large amounts of dirty data
> > >> queued for other devices.
> > >
> > > While I understand that you want to have per bdi throttling for those
> > > "special" files I am still missing how this is going to provide the
> > > additional room that the additnal 25% gave them previously. I might
> > > misremember or things have changed (what you mention as non-trivial
> > > heuristics) but PF_LESS_THROTTLE really needed that room to guarantee a
> > > forward progress. Care to expan some more on how this is handled now?
> > > Maybe we do not need it anymore but calling that out explicitly would be
> > > really helpful.
> > 
> > The 25% was a means to an end, not an end in itself.
> > 
> > The problem is that the NFS server needs to be able to write to the
> > backing filesystem when the dirty memory limits have been reached by
> > being totally consumed by dirty pages on the NFS filesystem.
> > 
> > The 25% was just a way of giving an allowance of dirty pages to nfsd
> > that could not be consumed by processes writing to an NFS filesystem.
> > i.e. it doesn't need 25% MORE, it needs 25% PRIVATELY.  Actually it only
> > really needs 1 page privately, but a few pages give better throughput
> > and 25% seemed like a good idea at the time.
> 
> Yes this part is clear to me.
>  
> > per-bdi throttling focuses on the "PRIVATELY" (the important bit) and
> > de-emphasises the 25% (the irrelevant detail).
> 
> It is still not clear to me how this patch is going to behave when the
> global dirty throttling is essentially equal to the per-bdi - e.g. there
> is only a single bdi and now the PF_LOCAL_THROTTLE process doesn't have
> anything private.

Let me think out loud so see whether I understand this properly. There are
two BDIs involved in NFS loop mount - the NFS virtual BDI (let's call it
simply NFS-bdi) and the bdi of the real filesystem that is backing NFS
(let's call this real-bdi). The case we are concerned about is when NFS-bdi
is full of dirty pages so that global dirty limit of the machine is
exceeded. Then flusher thread will take dirty pages from NFS-bdi and send
them over localhost to nfsd. Nfsd, which has PF_LOCAL_THROTTLE set, will take
these pages and write them to real-bdi. Now because PF_LOCAL_THROTTLE is
set for nfsd, the fact that we are over global limit does not take effect
and nfsd is still able to write to real-bdi until dirty limit on real-bdi
is reached. So things should work as Neil writes AFAIU.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
