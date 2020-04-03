Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 791F719D56D
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Apr 2020 13:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgDCLEC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Apr 2020 07:04:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45307 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgDCLEC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Apr 2020 07:04:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id t7so7969651wrw.12;
        Fri, 03 Apr 2020 04:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uKZeJ3QaYya1YXVrP4ptZzn73kQ2uIA9YdMAiYW3qiU=;
        b=bRFXPUocPPDDxK5sTdqdPo3dTezTWkCDR3FPrBlD70efz4aQukbSurMULRRL4RHcsv
         g+VxxG2TRkdFv7IOV4dZP9Rkqkp87IfR4AKm4oYyA5qTeQD6DIfjMe9SxH9fhH6rrPJF
         wyjHirBB1en9UNpCj/I1EPrzvT5lZpL096AOD3c27zq3oovx+DT9PYsnQsfr8HRzsJ/0
         dXkb/QXv5UGrQEK4PrAHq61xAgHeNsR92NJUfnltfFwVoPdrAasUvoCn+XkjYnTNWjF7
         638MoFZsuD1l3Gfg9l/ys5uLkPD8O0/Ta6TCrb1vTFV0D9QYF1Seh6XNjco+r5OdSO0M
         Uz2A==
X-Gm-Message-State: AGi0PuZOKMJKOGT8m4HG9pXqEDlvtdc0oRB1+RK9GCoixqesGlKql90q
        ynOoFdbcilGEIMsb0asScQI=
X-Google-Smtp-Source: APiQypLnsyKoca02cmMgitG6rzlmlWsncnvAW+5wBYZxxmEKLfRML3tOIzzWKNmTrdgpKhbofj5NbQ==
X-Received: by 2002:a05:6000:1205:: with SMTP id e5mr8928579wrx.73.1585911840404;
        Fri, 03 Apr 2020 04:04:00 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id 189sm11405996wme.31.2020.04.03.04.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 04:03:59 -0700 (PDT)
Date:   Fri, 3 Apr 2020 13:03:58 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     NeilBrown <neilb@suse.de>, Christoph Hellwig <hch@infradead.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "Anna.Schumaker@Netapp.com" <Anna.Schumaker@netapp.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2 - v2] MM: Discard NR_UNSTABLE_NFS, use NR_WRITEBACK
 instead.
Message-ID: <20200403110358.GB22681@dhcp22.suse.cz>
References: <87tv2b7q72.fsf@notabene.neil.brown.name>
 <87v9miydai.fsf@notabene.neil.brown.name>
 <87sghmyd8v.fsf@notabene.neil.brown.name>
 <87pncqyd7k.fsf@notabene.neil.brown.name>
 <20200402151009.GA14130@infradead.org>
 <87h7y1y0ra.fsf@notabene.neil.brown.name>
 <20200403094220.GA29920@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403094220.GA29920@quack2.suse.cz>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri 03-04-20 11:42:20, Jan Kara wrote:
[...]
> > diff --git a/mm/vmstat.c b/mm/vmstat.c
> > index 78d53378db99..d1291537bbb9 100644
> > --- a/mm/vmstat.c
> > +++ b/mm/vmstat.c
> > @@ -1162,7 +1162,6 @@ const char * const vmstat_text[] = {
> >  	"nr_file_hugepages",
> >  	"nr_file_pmdmapped",
> >  	"nr_anon_transparent_hugepages",
> > -	"nr_unstable",
> >  	"nr_vmscan_write",
> >  	"nr_vmscan_immediate_reclaim",
> >  	"nr_dirtied",
> 
> This is probably the most tricky to deal with given how /proc/vmstat is
> formatted. OTOH for this file there's good chance we'd get away with just
> deleting nr_unstable line because there are entries added to it in the
> middle (e.g. in 60fbf0ab5da1 last September) and nobody complained yet.
> 
> What do mm people think? How were changes to vmstat counters handled in the
> past?

Adding new counters in the middle seems to be generally OK. I would be
more worried about removing counters though. So if we can simply print a
phone value at the very end then this should be a reasonable workaround.
-- 
Michal Hocko
SUSE Labs
