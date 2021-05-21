Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA09A38C8BB
	for <lists+linux-nfs@lfdr.de>; Fri, 21 May 2021 15:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236275AbhEUNyP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 May 2021 09:54:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:39000 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236259AbhEUNyO (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 21 May 2021 09:54:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6A4FAAAA6;
        Fri, 21 May 2021 13:52:50 +0000 (UTC)
Date:   Fri, 21 May 2021 15:52:48 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     NeilBrown <neilb@suse.de>
Cc:     Steve Dickson <SteveD@redhat.com>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Alexey Kodanev <alexey.kodanev@oracle.com>
Subject: Re: [PATCH nfs-utils 1/2] Remove 'force' arg from cache_flush()
Message-ID: <YKe7MMg0hPs8Lf5Y@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210422191803.31511-1-pvorel@suse.cz>
 <20210422202334.GB25415@fieldses.org>
 <YILQip3nAxhpXP9+@pevik>
 <162035212343.24322.12361160756597283121@noble.neil.brown.name>
 <162122673178.19062.96081788305923933@noble.neil.brown.name>
 <289c5819-917a-39a7-9aa4-2a27ae7248c0@RedHat.com>
 <162156113063.19062.9406037279407040033@noble.neil.brown.name>
 <162156122215.19062.11710239266795260824@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162156122215.19062.11710239266795260824@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Neil,

> Since v4.17 the timestamp written to 'flush' is ignored,
> so there isn't much point choosing too precisely.

> For kernels since v4.3-rc3-13-g778620364ef5 it is safe
> to write 1 second beyond the current time.

> For earlier kernels, nothing is really safe (even the current
> behaviour), but writing one second beyond the current time isn't too bad
> in the unlikely case the people use a new nfs-utils on a 5 year old
> kernel.

> This remove a dependency for libnfs.a on 'etab' being declare,
> so svcgssd no longer needs to declare it.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
