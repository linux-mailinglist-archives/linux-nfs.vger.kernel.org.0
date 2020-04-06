Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2E7F19F11A
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Apr 2020 09:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgDFHo5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Apr 2020 03:44:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53402 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgDFHo5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Apr 2020 03:44:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id d77so13625468wmd.3;
        Mon, 06 Apr 2020 00:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=txWInbuQbmkgFxJ+50xnQXLhTEQvs1Jqq2HY6J0OmlU=;
        b=QoMOsFRiahP6Pg7Gai160asclW5Lzm+ToLoPpt83KcHbhU8hT/5CXufMx2snTIuvvo
         Bsc5BQSEWDlAM8SoqvgXx4Az+95SK3L4nhqt5pORwyNvxLA47FGtnUAhAMcnrCu6H6Oh
         NiGULMv/F5QmibD+1EYA3bMVgxW57vO5ro87zGcipVesoI82bWOR7H5f8/z7U37Mgy9p
         NDaDpYzrfnrElIr1BBWag9VSJbOvMbjj5He8pjXtJGsL0nqV2ifdZ6G7ylVpRWJZk8cd
         Wv2YIZEg6lIyT4I67M7nIbFQ3cwnNzWR7x/w107ic1QkZP0V7YbwwM+XQc0Mv74KGaEN
         Pdjg==
X-Gm-Message-State: AGi0PuY39d+/iEHlQptkN8JxnbrQpIhZR8k++XgbTe35tgZI/RHge60A
        qNbTJmIJ99sqqtdDDkCNxts=
X-Google-Smtp-Source: APiQypJ/uoIUR+40nexUPOLJDWAC+iVUJJZll3wmjJET1u6SyNHZsHCm9tunzpCMG0peDimrSZlprA==
X-Received: by 2002:a1c:bd8b:: with SMTP id n133mr10454476wmf.175.1586159095092;
        Mon, 06 Apr 2020 00:44:55 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id q11sm24372569wme.0.2020.04.06.00.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 00:44:54 -0700 (PDT)
Date:   Mon, 6 Apr 2020 09:44:53 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "Anna.Schumaker@Netapp.com" <Anna.Schumaker@Netapp.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] MM: replace PF_LESS_THROTTLE with PF_LOCAL_THROTTLE
Message-ID: <20200406074453.GH19426@dhcp22.suse.cz>
References: <87tv2b7q72.fsf@notabene.neil.brown.name>
 <87v9miydai.fsf@notabene.neil.brown.name>
 <87sghmyd8v.fsf@notabene.neil.brown.name>
 <20200403151534.GG22681@dhcp22.suse.cz>
 <878sjcxn7i.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878sjcxn7i.fsf@notabene.neil.brown.name>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat 04-04-20 08:40:17, Neil Brown wrote:
> On Fri, Apr 03 2020, Michal Hocko wrote:
> 
> > On Thu 02-04-20 10:53:20, Neil Brown wrote:
> >> 
> >> PF_LESS_THROTTLE exists for loop-back nfsd, and a similar need in the
> >> loop block driver, where a daemon needs to write to one bdi in
> >> order to free up writes queued to another bdi.
> >> 
> >> The daemon sets PF_LESS_THROTTLE and gets a larger allowance of dirty
> >> pages, so that it can still dirty pages after other processses have been
> >> throttled.
> >> 
> >> This approach was designed when all threads were blocked equally,
> >> independently on which device they were writing to, or how fast it was.
> >> Since that time the writeback algorithm has changed substantially with
> >> different threads getting different allowances based on non-trivial
> >> heuristics.  This means the simple "add 25%" heuristic is no longer
> >> reliable.
> >> 
> >> This patch changes the heuristic to ignore the global limits and
> >> consider only the limit relevant to the bdi being written to.  This
> >> approach is already available for BDI_CAP_STRICTLIMIT users (fuse) and
> >> should not introduce surprises.  This has the desired result of
> >> protecting the task from the consequences of large amounts of dirty data
> >> queued for other devices.
> >
> > While I understand that you want to have per bdi throttling for those
> > "special" files I am still missing how this is going to provide the
> > additional room that the additnal 25% gave them previously. I might
> > misremember or things have changed (what you mention as non-trivial
> > heuristics) but PF_LESS_THROTTLE really needed that room to guarantee a
> > forward progress. Care to expan some more on how this is handled now?
> > Maybe we do not need it anymore but calling that out explicitly would be
> > really helpful.
> 
> The 25% was a means to an end, not an end in itself.
> 
> The problem is that the NFS server needs to be able to write to the
> backing filesystem when the dirty memory limits have been reached by
> being totally consumed by dirty pages on the NFS filesystem.
> 
> The 25% was just a way of giving an allowance of dirty pages to nfsd
> that could not be consumed by processes writing to an NFS filesystem.
> i.e. it doesn't need 25% MORE, it needs 25% PRIVATELY.  Actually it only
> really needs 1 page privately, but a few pages give better throughput
> and 25% seemed like a good idea at the time.

Yes this part is clear to me.
 
> per-bdi throttling focuses on the "PRIVATELY" (the important bit) and
> de-emphasises the 25% (the irrelevant detail).

It is still not clear to me how this patch is going to behave when the
global dirty throttling is essentially equal to the per-bdi - e.g. there
is only a single bdi and now the PF_LOCAL_THROTTLE process doesn't have
anything private.

-- 
Michal Hocko
SUSE Labs
