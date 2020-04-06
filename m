Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEF419F10C
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Apr 2020 09:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgDFHlX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Apr 2020 03:41:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42379 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgDFHlW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Apr 2020 03:41:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id h15so16132036wrx.9;
        Mon, 06 Apr 2020 00:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nAQr+9K38MgvDYYgFchl8YBFkKBoGytRmVlPwECNUXM=;
        b=DX31JS7B9ArZy3oNsK1Yc4T0VMelX1Co6oQFIkXFohs0tVjGP+DuY1Tg03kQk3wrjv
         gHnzavd8trWlZRPI05+PNq/BDhkPb5SeeFXHKGIlzzQT7DVye+jKwhWtAGGJagzxzrIe
         lbiIjuFHt2KErVFW1fM60Ypvz74zfb/vPQqd6jjYHSjDnVRg2Wnvtnn5G939SVBYbp9w
         ui3ls4naDHdNoA4wpmDzZsVKA974CihHdlNfa7U2YUES1wvVzn33LOTQejUe9Tm6q6iv
         fJmHjw8G/1E4fbIcXQAxdZw3B8WHkbcs+h+6SdGAfEbTd2w0AyVQQhPx5IdsrTRaYxgD
         TqGg==
X-Gm-Message-State: AGi0Pub/1D6/z5K/XL1ekY5FJpaZLAXQItQRRxaVFQjzcgoWsH0mbmn8
        PN8AqJfpP6ez4GcskAfsiiA=
X-Google-Smtp-Source: APiQypKPzaN/Qn9P7OD6uTxybVieU5yFLGLohLtLIFIR3egzCrHscNwlVQ/Uk9zL2X5VoX0jhSBGrA==
X-Received: by 2002:adf:904e:: with SMTP id h72mr4288049wrh.367.1586158881210;
        Mon, 06 Apr 2020 00:41:21 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id o129sm15907239wma.20.2020.04.06.00.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 00:41:20 -0700 (PDT)
Date:   Mon, 6 Apr 2020 09:41:19 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "Anna.Schumaker@Netapp.com" <Anna.Schumaker@netapp.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2 - v2] MM: Discard NR_UNSTABLE_NFS, use NR_WRITEBACK
 instead.
Message-ID: <20200406074119.GG19426@dhcp22.suse.cz>
References: <87tv2b7q72.fsf@notabene.neil.brown.name>
 <87v9miydai.fsf@notabene.neil.brown.name>
 <87sghmyd8v.fsf@notabene.neil.brown.name>
 <87pncqyd7k.fsf@notabene.neil.brown.name>
 <20200402151009.GA14130@infradead.org>
 <87h7y1y0ra.fsf@notabene.neil.brown.name>
 <20200403094220.GA29920@quack2.suse.cz>
 <20200403110358.GB22681@dhcp22.suse.cz>
 <87pnclwjvr.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pnclwjvr.fsf@notabene.neil.brown.name>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon 06-04-20 10:14:16, Neil Brown wrote:
> On Fri, Apr 03 2020, Michal Hocko wrote:
> 
> > On Fri 03-04-20 11:42:20, Jan Kara wrote:
> > [...]
> >> > diff --git a/mm/vmstat.c b/mm/vmstat.c
> >> > index 78d53378db99..d1291537bbb9 100644
> >> > --- a/mm/vmstat.c
> >> > +++ b/mm/vmstat.c
> >> > @@ -1162,7 +1162,6 @@ const char * const vmstat_text[] = {
> >> >  	"nr_file_hugepages",
> >> >  	"nr_file_pmdmapped",
> >> >  	"nr_anon_transparent_hugepages",
> >> > -	"nr_unstable",
> >> >  	"nr_vmscan_write",
> >> >  	"nr_vmscan_immediate_reclaim",
> >> >  	"nr_dirtied",
> >> 
> >> This is probably the most tricky to deal with given how /proc/vmstat is
> >> formatted. OTOH for this file there's good chance we'd get away with just
> >> deleting nr_unstable line because there are entries added to it in the
> >> middle (e.g. in 60fbf0ab5da1 last September) and nobody complained yet.
> >> 
> >> What do mm people think? How were changes to vmstat counters handled in the
> >> past?
> >
> > Adding new counters in the middle seems to be generally OK. I would be
> > more worried about removing counters though. So if we can simply print a
> > phone value at the very end then this should be a reasonable workaround.
> 
> At the very end?
> Do you mean not have "nr_unstable 0" appear at all, but having "dummy 0"
> appear at the end just so that the number of lines doesn't decrease?
> Am I misunderstanding?

Sorry for not being clear. I meant semething like
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 78d53378db99..836e3f7a7aff 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1705,8 +1705,16 @@ static void *vmstat_start(struct seq_file *m, loff_t *pos)
 static void *vmstat_next(struct seq_file *m, void *arg, loff_t *pos)
 {
 	(*pos)++;
-	if (*pos >= NR_VMSTAT_ITEMS)
+	if (*pos >= NR_VMSTAT_ITEMS) {
+		/*
+		 * deprecated counters which are no longer represented
+		 * in vmstat arrays. We just lie about them to be always
+		 * 0 to not break userspace which might expect them in
+		 * int the output.
+		 */
+		seq_puts(m, "nr_unstable 0")
 		return NULL;
+	}
 	return (unsigned long *)m->private + *pos;
 }
 

-- 
Michal Hocko
SUSE Labs
