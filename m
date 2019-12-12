Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2188211D4D2
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Dec 2019 19:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbfLLSEA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Dec 2019 13:04:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:53378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730034AbfLLSD7 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 12 Dec 2019 13:03:59 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [199.201.64.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65CC7206DA;
        Thu, 12 Dec 2019 18:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576173839;
        bh=cZV989DdYo9B9NVAqpSi0dlI1udeZn5Oa6mQtxQHc08=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=n13dv87dgFevQzdUeJHbKYQ3YsqGQqtTbjX7j47+p3TV5ooU736D/cx/1AgU4Xsjq
         5m+OsPbdg4tPh8HWhMAXNmwya28fwIXsS1BKo1w3ppgJJFLNyI4LNKl8tEJDqLkr8z
         Ajr84HjIiD0JI3HkaN6YkeHiVwDSqfX+KHMJ1qJU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id ACCC73522757; Thu, 12 Dec 2019 10:03:58 -0800 (PST)
Date:   Thu, 12 Dec 2019 10:03:58 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "madhuparnabhowmik04@gmail.com" <madhuparnabhowmik04@gmail.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs: nfs: dir.c: Fix sparse error
Message-ID: <20191212180358.GX2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <201912110621.WJ6oENgf%lkp@intel.com>
 <20191211074842.21400-1-madhuparnabhowmik04@gmail.com>
 <20191212041406.GT2889@paulmck-ThinkPad-P72>
 <5614739335088d3e9baff43b752df04b84a8ad14.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5614739335088d3e9baff43b752df04b84a8ad14.camel@hammerspace.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Dec 12, 2019 at 01:45:29PM +0000, Trond Myklebust wrote:
> On Wed, 2019-12-11 at 20:14 -0800, Paul E. McKenney wrote:
> > On Wed, Dec 11, 2019 at 01:18:42PM +0530, 
> > madhuparnabhowmik04@gmail.com wrote:
> > > This build error is because the macro list_tail_rcu() is
> > > not yet present in the mainline kernel.
> > > 
> > > This patch is dependent on the patch : 
> > > https://lore.kernel.org/linux-kernel-mentees/CAF65HP2SC89k9HJZfcLgeOMRPBKRyasCMiLo2gZgBKycjHuU6A@mail.gmail.com/T/#t
> > 
> > If the NFS folks are OK with it, I would be happy to take it in -rcu,
> > where the list_tail_rcu() patch is currently located.
> 
> That would be fine with me.

Very good!  I have queued it.

							Thanx, Paul
