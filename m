Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68DC3A03BE
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2019 15:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfH1Nvc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Aug 2019 09:51:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57012 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbfH1Nvc (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 28 Aug 2019 09:51:32 -0400
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com [209.85.219.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EE29785545
        for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2019 13:51:31 +0000 (UTC)
Received: by mail-yb1-f200.google.com with SMTP id f71so58298ybg.6
        for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2019 06:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=HKysrA43CfPdLwGB6BKECbFeeC5LIBlILNn8D1b7b3o=;
        b=WOv9rrmO6g6o8hLc4HB6czvo6kq+hx2fjqiTgQfbbfiqbFsloHuukFFQoOkoc8V/vK
         U/UFTXqD2qhVbvzZmAwMrU1AJxfVErMjJxU588LOqT4EUHMMyAuSzumTOdr8aH8pfynL
         ytDY7hQG9G6YoYPo3o1Hb8fkm63C9nrYTNgGPImTxEc1U4T2hCqNVvZ8E8FdBEkdp+4P
         C0ypXydT0HdqeSRQB/yEI9nx9rp7YUwQ1K3qYtC/zBs2pA2xJDx8sqA+AbVgd1QtPeF+
         rlIkiHZZDd/Q2tvkNZMGQy517DaMtO/1z4wEic2gFcSjOPz/OlrDNjgBMh2GHY1SQ2b2
         x8bg==
X-Gm-Message-State: APjAAAX7pCFrp9AscKYk4GVLz5EhVozVwk9mL4VIUf47jsksI46U4o+L
        FHNIyF4hQdQHEd56VlW8yM5E0XDgLsMVkJhmLzTutzDuUf9jyugEtIaQL+GbnB/OTx0Ey1hos+n
        /pXtu0FQ/VEmPlyMtvc1i
X-Received: by 2002:a25:b850:: with SMTP id b16mr3165781ybm.172.1567000291353;
        Wed, 28 Aug 2019 06:51:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwKN3SezWnJXr59M7/6ySJdJ2GSaXEstCVehmThvMWX5sBRHeoYaNRrl4VLvh+eSGcOYVsyFQ==
X-Received: by 2002:a25:b850:: with SMTP id b16mr3165765ybm.172.1567000291060;
        Wed, 28 Aug 2019 06:51:31 -0700 (PDT)
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id a201sm511796ywa.19.2019.08.28.06.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 06:51:30 -0700 (PDT)
Message-ID: <ed2a86da204cbf644ef2dada4bda2b899da48764.camel@redhat.com>
Subject: Re: [PATCH 0/3] Handling NFSv3 I/O errors in knfsd
From:   Jeff Layton <jlayton@redhat.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Date:   Wed, 28 Aug 2019 09:51:28 -0400
In-Reply-To: <20190828134839.GA26492@fieldses.org>
References: <20190826165021.81075-1-trond.myklebust@hammerspace.com>
         <20190826205156.GA27834@fieldses.org>
         <ef9f2791ef395d7c968a386ce0a32ea503d6478f.camel@hammerspace.com>
         <61F77AD6-BD02-4322-B944-0DC263EB9BD8@oracle.com>
         <ec7a06f8e74867e65c26580e8504e2879f4cd595.camel@hammerspace.com>
         <20190827145819.GB9804@fieldses.org> <20190827145912.GC9804@fieldses.org>
         <1ee75165d548b336f5724b6d655aa2545b9270c3.camel@hammerspace.com>
         <20190828134839.GA26492@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2019-08-28 at 09:48 -0400, bfields@fieldses.org wrote:
> On Tue, Aug 27, 2019 at 03:15:35PM +0000, Trond Myklebust wrote:
> > I'm open to other suggestions, but I'm having trouble finding one that
> > can scale correctly (i.e. not require per-client tracking), prevent
> > silent corruption (by causing clients to miss errors), while not
> > relying on optional features that may not be implemented by all NFSv3
> > clients (e.g. per-file write verifiers are not implemented by *BSD).
> > 
> > That said, it seems to me that to do nothing should not be an option,
> > as that would imply tolerating silent corruption of file data.
> 
> So should we increment the boot verifier every time we discover an error
> on an asynchronous write?
> 

I think so. Otherwise, only one client will ever see that error.
-- 
Jeff Layton <jlayton@redhat.com>

