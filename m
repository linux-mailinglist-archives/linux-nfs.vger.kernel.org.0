Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2631F1CDC6D
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2020 16:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbgEKOB7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 May 2020 10:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727792AbgEKOB6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 May 2020 10:01:58 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00::f03c:91ff:fe50:41d6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B845FC061A0C
        for <linux-nfs@vger.kernel.org>; Mon, 11 May 2020 07:01:58 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 516D34F44; Mon, 11 May 2020 10:01:58 -0400 (EDT)
Date:   Mon, 11 May 2020 10:01:58 -0400
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "msys.mizuma@gmail.com" <msys.mizuma@gmail.com>,
        "schumakeranna@gmail.com" <schumakeranna@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfs: fix NULL deference in nfs4_get_valid_delegation
Message-ID: <20200511140158.GD8629@fieldses.org>
References: <20200508221935.GA11225@fieldses.org>
 <20200511121054.l2j34vnwqxhvd2ao@gabell>
 <20200511131637.GA8629@fieldses.org>
 <8f9f84f11df6f5caf054d1eada2d91ea158a6882.camel@hammerspace.com>
 <20200511135745.GB8629@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511135745.GB8629@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, May 11, 2020 at 09:57:45AM -0400, bfields@fieldses.org wrote:
> On Mon, May 11, 2020 at 01:43:30PM +0000, Trond Myklebust wrote:
> > On Mon, 2020-05-11 at 09:16 -0400, J. Bruce Fields wrote:
> > > Thanks, applying.--b.
> > > 
> > 
> > You're applying? So should I remove it from the NFS client bugfixes?
> 
> No.  Sorry, I responded to the wrong email!

I do have a patch including the tags and oops provided by Masayoshi
Mizuma, if you'd like to take that instead.  See followup.--b.
