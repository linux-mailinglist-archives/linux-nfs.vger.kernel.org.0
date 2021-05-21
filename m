Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22A538C8D0
	for <lists+linux-nfs@lfdr.de>; Fri, 21 May 2021 15:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbhEUN7g (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 May 2021 09:59:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:44466 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236441AbhEUN6r (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 21 May 2021 09:58:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9D4ACAC11;
        Fri, 21 May 2021 13:57:23 +0000 (UTC)
Date:   Fri, 21 May 2021 15:57:21 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     NeilBrown <neilb@suse.de>
Cc:     Steve Dickson <SteveD@redhat.com>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Alexey Kodanev <alexey.kodanev@oracle.com>
Subject: Re: [PATCH nfs-utils 2/2] Move declaration of etab and rmtab into
 libraries
Message-ID: <YKe8QU4GWIneOwXN@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210422191803.31511-1-pvorel@suse.cz>
 <20210422202334.GB25415@fieldses.org>
 <YILQip3nAxhpXP9+@pevik>
 <162035212343.24322.12361160756597283121@noble.neil.brown.name>
 <162122673178.19062.96081788305923933@noble.neil.brown.name>
 <289c5819-917a-39a7-9aa4-2a27ae7248c0@RedHat.com>
 <162156113063.19062.9406037279407040033@noble.neil.brown.name>
 <162156122215.19062.11710239266795260824@noble.neil.brown.name>
 <162156127225.19062.3275458295434454950@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162156127225.19062.3275458295434454950@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Neil,

> There are two global "struct stat_paths" structures: etab and rmtab.
> They are currently needed by some library code so any program which is
> linked with that library code needs to declare the structures even if it
> doesn't use the functionality.  This is clumsy and error-prone.

> Instead: have the library declare the structure and put the definition
> in a header file.  Now programs only need to know about these structures
> if they use the functionality.

> 'rmtab' is now declared in libnfs.a (rmtab.c).  'etab' is declared in
> export.a (xtab.c).

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Nice cleanup!

Kind regards,
Petr
