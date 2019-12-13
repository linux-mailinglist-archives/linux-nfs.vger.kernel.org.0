Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9176211DB90
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Dec 2019 02:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731465AbfLMBQM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Dec 2019 20:16:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:41776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727084AbfLMBQL (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 12 Dec 2019 20:16:11 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [199.201.64.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E864B2173E;
        Fri, 13 Dec 2019 01:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576199770;
        bh=41UXekEdF9kavlN11G4wL1lFhr5jX6Gv12aUkd97nZU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CIHvI4iA5Eab4AxzB1ehbOKRX3V0VZqXs9o2dsLS3Ww31ZEIHy3ZaaTARQTO58q1/
         O17lww/L0A4aA8YGeNLuEvIjGBbZGK2GbN6zm0mUTxj6a+r7w6OpHmobyrMj0/SQjg
         zMEChoKxDLuJKMh3n9Gdo1Sb3arovX5qCJ22OKEE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7180835227E8; Thu, 12 Dec 2019 17:16:10 -0800 (PST)
Date:   Thu, 12 Dec 2019 17:16:10 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     madhuparnabhowmik04@gmail.com, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, linux-nfs@vger.kernel.org,
        rcu@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: nfs: dir.c: Fix sparse error
Message-ID: <20191213011610.GC2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191206151640.10966-1-madhuparnabhowmik04@gmail.com>
 <20191206160238.GE2889@paulmck-ThinkPad-P72>
 <20191212215534.GE129023@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212215534.GE129023@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Dec 12, 2019 at 04:55:34PM -0500, Joel Fernandes wrote:
> On Fri, Dec 06, 2019 at 08:02:38AM -0800, Paul E. McKenney wrote:
> 
> Thanks for fixing these issues and I caught up with all the patches.
> 
> > 
> > o	Create a list that is safe for bidirectional RCU traversal.
> > 	This can use list_head, and would need these functions,
> > 	give or take the exact names:
> 
> On a related topic, I was trying to reason about how one could come up with
> bidirectional traversal without ever getting rid of poisoning.
> 
> As you noted in another post, if during traversal, the node is deleted and
> poisoned, then the traverser can access a poisoned pointer. If the list is
> being traversed in reverse (by following prev), then poisioning could hurt
> it.
> 
> Even with the below modifications, poisoning would still hurt it. No? Were
> you suggesting to remove poisoning for such bidirectional RCU list?

Yes.  We removed forward poisoning from list_del_rcu(), and a
list_del_rcuprev() or whatever name would need to avoid poisoning both
pointers.

							Thanx, Paul

> Sorry if I missed something.
> thanks,
> 
>  - Joel
> 
> 
> > 	list_add_tail_rcuprev():  This is like list_add_tail_rcu(),
> > 	but also has smp_store_release() for ->prev.  (As in there is
> > 	also a __list_add_rcuprev() helper that actually contains the
> > 	additional smp_store_release().)
> > 
> > 	list_del_rcuprev():  This can be exactly __list_del_entry(),
> > 	but with the assignment to ->prev in __list_del() becoming
> > 	WRITE_ONCE().  And it looks like callers to __list_del_entry()
> > 	and __list_del() might need some attention!  And these might
> > 	result in additional users of *_rcuprev().
> > 
> > 	list_prev_rcu() as in your first patch, but with READ_ONCE().
> > 	Otherwise DEC Alpha can fail.  And more subtle compiler issues
> > 	can appear on other architectures.
> > 
> > 	Note that list_move_tail() will be OK give or take *_ONCE().
> > 	It might be better to define a list_move_tail_rcuprev(), given
> > 	the large number of users of list_move_tail() -- some of these
> > 	users might not like even the possibility of added overhead due
> > 	to volatile accesses.  ;-)
> > 
> > Or am I missing something subtle here?
> > 
> > 							Thanx, Paul
