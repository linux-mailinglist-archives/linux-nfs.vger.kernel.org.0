Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DE85A1829
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Aug 2022 19:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbiHYRx2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Aug 2022 13:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbiHYRxZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Aug 2022 13:53:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7C5BBA50
        for <linux-nfs@vger.kernel.org>; Thu, 25 Aug 2022 10:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S+UHXo2fScCLrBoYkqN6NCKqlM8drcTOel4+gEhl8Lk=; b=TpH2QkXHF6O8ekHSiPcAZ11Nn7
        +aFNT7LuGKOg4G9X6fl+iKjiWRG2xlHB6gmUEumKmu5TMWPL1LecFZhqcCr9qu2G78BqJs78Yn5iF
        OIVTMHDQ9CmV+H9jjLqj3N/kcym2YE49QA1NTr1clqr7prDmXSYH94yrgn9/f3EZYgepi5m1Nl2gK
        lueIQRHxrlPjUIHqw5knBPhWK+fVKXRXROjeIAoSKPbCelS++eaThkA3np0uLFrzEIy6mxz2pFRFG
        0aHUsYLJc4SFzd2N0okU2+6Pr5FD8vnm7UI8JTs6NftzkPA9+igUUBrtL8okaOkNaKvO/gvHAX3hi
        rWNV/DfA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oRH2Z-00HROI-5G; Thu, 25 Aug 2022 17:53:15 +0000
Date:   Thu, 25 Aug 2022 18:53:15 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "daire.byrne@gmail.com" <daire.byrne@gmail.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "benmaynard@google.com" <benmaynard@google.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "dwysocha@redhat.com" <dwysocha@redhat.com>
Subject: Re: [RFC PATCH 2/3] NFS: Add support for netfs in struct nfs_inode
 and Kconfig
Message-ID: <Ywe3C/EvKFYEwKPy@casper.infradead.org>
References: <20220824093501.384755-1-dwysocha@redhat.com>
 <20220824093501.384755-3-dwysocha@redhat.com>
 <429ecc819fcffe63d60dbb2b72f9022d2a21ddd8.camel@hammerspace.com>
 <CALF+zOknvMZyufSUD-g9Z9Y5RfwE-vUFT+CF0kxqbcpR=yJPJw@mail.gmail.com>
 <216681.1661350326@warthog.procyon.org.uk>
 <5ab3188affa7e56e68a4f66a42f45d7086c1da23.camel@hammerspace.com>
 <YwZXfSXMzZgaSPAg@casper.infradead.org>
 <5dfadceb26da1b4d8d499221a5ff1d3c80ad59c0.camel@hammerspace.com>
 <YweOySTkKQ3PDLCv@casper.infradead.org>
 <b4cbbdef254e9e0e6feb41455d809aaf0c5abfdb.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4cbbdef254e9e0e6feb41455d809aaf0c5abfdb.camel@hammerspace.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Aug 25, 2022 at 03:32:25PM +0000, Trond Myklebust wrote:
> I'm not talking about the transition of dirty->clean. We already deal
> with that. I'm talking about supporting large folios on read-mainly
> workloads.
> 
> NFS can happily support 1MB sized folios, or even larger than that if
> there is a compelling reason to do so.
> 
> However, having to read in the entire folio contents if the user is
> just asking for a few bytes on a database-style random read workload
> can quickly get onerous.

Ah, we don't do that.  If the user is only asking for a few bytes and
there's no indication that it's part of a streaming read, we allocate &
fill a single page, just as before.  We adapt to the user's workload
and only allocate multi-page folios when there's evidence that it'll
be useful to do so.

