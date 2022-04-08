Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1E54F9D85
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Apr 2022 21:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbiDHTLw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 Apr 2022 15:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbiDHTLv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 8 Apr 2022 15:11:51 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609C43631D
        for <linux-nfs@vger.kernel.org>; Fri,  8 Apr 2022 12:09:46 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id z19so11478143qtw.2
        for <linux-nfs@vger.kernel.org>; Fri, 08 Apr 2022 12:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=91CXBQ+QrrLDOnPHUKIzRlaTu5VpTvLlE8RRdbceTKE=;
        b=Pea+YagxkPeueG0equs+40ADF1bGt2mGTubU7yEGQ9D5EZzlKZj3yLLBo1bo+tUp3t
         l01fKxrkAr9RsNHd2kJktq57jwPNwMsRwRZv0HZ8L3ZNsD5+79fz0NJpBxfqFObARLyb
         mpDpmII4pvnnZVMpYArpf51d82RzJwVat/cd59joy08nQkusIHZROV8kik/ENQmIW+h7
         ntuwZdlOyF13ckkPtdzMThkDE5Au7ZOQEOA15QzEsP0GSoEzkN6qsyw9L8Yc6rrmM0Mp
         DiSae7DtuJBTCpFMPMEmAQfNuTA8mQHb9uIpHIXe7PZj05pUCqhxSlfAO8L247TOo7aS
         Km8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=91CXBQ+QrrLDOnPHUKIzRlaTu5VpTvLlE8RRdbceTKE=;
        b=OwCoPQJteEPl54cnud/UBGIQpQvN7mZvqukDhev0mmV0cN82SIEttibZosjIKMPaAD
         TrWtNo7yPocMbzu1J3QrBEY/1PIQIcWm3n3XwA5fKTsGkBLTORNI1eYCnwHdVqoQI4hq
         DTAKYtjNugZ18aP9ku9qHEdpyX5GKpgOT5/MyExxGJa97jJtA+BU3qawDf0sa6ezroZE
         4YoWZ/Na058qtAxzfLyaAaE6oeCZ/A/T5I38c56YlVSZe148jJtisixqii2BtxgmdizS
         GiS2T9M0qgOHQuaHdj+qYFssMj+ptM0zpMxzZrbjemkBc5YmzOpBLCsFcCoygAUZbZ4S
         3LMA==
X-Gm-Message-State: AOAM530tUzdJIA4uHLgLXlesPeo0a4Zxl5ecagnl/2UGcGKZrEl4xsQj
        Mn2zd2py5u1ohV6ERz/LAdqozg==
X-Google-Smtp-Source: ABdhPJzea53eTcF7VeofLNU82BNlFWAWkd0eT1DoksHxj+Lxar1co0V5fVEZCpnUJtJil3Uog6zHIw==
X-Received: by 2002:ac8:5c90:0:b0:2e2:15c0:a5f3 with SMTP id r16-20020ac85c90000000b002e215c0a5f3mr17316917qta.332.1649444985335;
        Fri, 08 Apr 2022 12:09:45 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v3-20020a05622a014300b002e1dcd4cfa9sm19653356qtw.64.2022.04.08.12.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 12:09:44 -0700 (PDT)
Date:   Fri, 8 Apr 2022 12:09:32 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Chuck Lever III <chuck.lever@oracle.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Hemment <markhemm@googlemail.com>,
        Patrice CHOTARD <patrice.chotard@foss.st.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: Regression in xfstests on tmpfs-backed NFS exports
In-Reply-To: <C7966059-D583-4B20-A838-067BAE86FB3E@oracle.com>
Message-ID: <8058d02d-d8b2-4d7a-a535-a78719e996@google.com>
References: <673D708E-2DFA-4812-BB63-6A437E0C72EE@oracle.com> <11f319-c9a-4648-bfbb-dc5a83c774@google.com> <2B7AF707-67B1-4ED8-A29F-957C26B7F87A@oracle.com> <c5ea49a-1a76-8cf9-5c76-4bb31aa3d458@google.com> <C7966059-D583-4B20-A838-067BAE86FB3E@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 8 Apr 2022, Chuck Lever III wrote:
> > On Apr 7, 2022, at 6:26 PM, Hugh Dickins <hughd@google.com> wrote:
> > On Thu, 7 Apr 2022, Chuck Lever III wrote:
> >> 
> >> 847 static int
> >> 848 nfsd_splice_actor(struct pipe_inode_info *pipe, struct pipe_buffer *buf,
> >> 849                   struct splice_desc *sd)
> >> 850 {
> >> 851         struct svc_rqst *rqstp = sd->u.data;
> >> 852         struct page **pp = rqstp->rq_next_page;
> >> 853         struct page *page = buf->page;
> >> 854 
> >> 855         if (rqstp->rq_res.page_len == 0) {
> >> 856                 svc_rqst_replace_page(rqstp, page);
> >> 857                 rqstp->rq_res.page_base = buf->offset;
> >> 858         } else if (page != pp[-1]) {
> >> 859                 svc_rqst_replace_page(rqstp, page);
> >> 860         }
> >> 861         rqstp->rq_res.page_len += sd->len;
> >> 862 
> >> 863         return sd->len;
> >> 864 }
> >> 
> >> rq_next_page should point to the first unused element of
> >> rqstp->rq_pages, so IIUC that check is looking for the
> >> final page that is part of the READ payload.
> >> 
> >> But that does suggest that if page -> ZERO_PAGE and so does
> >> pp[-1], then svc_rqst_replace_page() would not be invoked.
> 
> To put a little more color on this, I think the idea here
> is to prevent releasing the same page twice. It might be
> possible that NFSD can add the same page to the rq_pages
> array more than once, and we don't want to do a double
> put_page().
> 
> The only time I can think this might happen is if the
> READ payload is partially contained in the page that
> contains the NFS header. I'm not sure that can ever
> happen these days.

I'd have thought that if a page were repeated, then its refcount would
have been raised twice, and so require a double put_page().  But it's
no concern of mine.  The only thing I'd say is, if you do find a good
way to robustify that code for duplicates, please don't make it
conditional on ZERO_PAGE - that's just a special case which I
mis-introduced and is now about to go away.

> > 
> > We might be able to avoid that revert, and go the whole way to using
> > iov_iter_zero() instead.  But the significant slowness of clear_user()
> > relative to copy to user, on x86 at least, does ask for a hybrid.
> > 
> > Suggested patch below, on top of 5.18-rc1, passes my own testing:
> > but will it pass yours?  It seems to me safe, and as fast as before,
> > but we don't know yet if this iov_iter_zero() works right for you.
> > Chuck, please give it a go and let us know.
> 
> Applied to stock v5.18-rc1. The tests pass as expected.

Great, thanks a lot, I'll move ahead with sending akpm the patch
with a proper commit message.

Hugh
