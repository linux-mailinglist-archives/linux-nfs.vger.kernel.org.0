Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DED4488CCF
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Jan 2022 23:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbiAIWQ1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 9 Jan 2022 17:16:27 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:47950 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234557AbiAIWQ1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 9 Jan 2022 17:16:27 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 513721F396;
        Sun,  9 Jan 2022 22:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641766586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GA0PfCKC1mzEDLAS7x1Kb0gX7HbfikiDRHGxUtuEkag=;
        b=qiVvZExlVGZ/4OjiOpOKeBUqmsMPut5IFzGNSSFZvODtDRmIUibVMNfNPcyze1qOEFAXJl
        W47ORb5jcX+EEmxgONomK2Rbndr3+bkGCfJKnVHVYGt/uWsQ4wIC2lvQgCdW1nZ+ua/FB9
        BjHGZeDsqJyHScS4R3vJWpTfzkvsDis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641766586;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GA0PfCKC1mzEDLAS7x1Kb0gX7HbfikiDRHGxUtuEkag=;
        b=zuFrlUTlt3Jv8b+PDkhm3mlkNDEA/JcfLG+Cxvj4BXh4Kbka+fuqIQeMhJaY8gRGI6eIPq
        z02PGxh37vFDYxDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0E921323E;
        Sun,  9 Jan 2022 22:16:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +UhkG7he22F4ZwAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 09 Jan 2022 22:16:24 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "'bfields@fieldses.org'" <bfields@fieldses.org>
Cc:     "inoguchi.yuki@fujitsu.com" <inoguchi.yuki@fujitsu.com>,
        "'Trond Myklebust'" <trondmy@hammerspace.com>,
        "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>,
        "'mbenjami@redhat.com'" <mbenjami@redhat.com>
Subject: Re: client caching and locks
In-reply-to: <20220106141628.GA7105@fieldses.org>
References: <20201006172607.GA32640@fieldses.org>,
 <164066831190.25899.16641224253864656420@noble.neil.brown.name>,
 <20220103162041.GC21514@fieldses.org>, =?utf-8?q?=3COSZPR01MB7050F9737016E8?=
 =?utf-8?q?E3F0FD5255EF4A9=40OSZPR01MB7050=2Ejpnprd01=2Eprod=2Eoutlook=2Ecom?=
 =?utf-8?q?=3E=2C?=
 <03e4cc01e9e66e523474c10846ee22147b78addf.camel@hammerspace.com>,
 <20220104153205.GA7815@fieldses.org>,
 <1257915fc5fd768e6c1c70fd3e8e3ed3fa1dc33e.camel@hammerspace.com>, 
 =?utf-8?q?=3COSZPR01MB7050C5098D47514FFEC2DA82EF4B9=40OSZPR01MB7050=2Ejpnpr?=
 =?utf-8?q?d01=2Eprod=2Eoutlook=2Ecom=3E=2C?=
 <20220105220353.GF25384@fieldses.org>, =?utf-8?q?=3COSZPR01MB7050BC53F1F38F?=
 =?utf-8?q?AA579E03B3EF4C9=40OSZPR01MB7050=2Ejpnprd01=2Eprod=2Eoutlook=2Ecom?=
 =?utf-8?q?=3E=2C?= <20220106141628.GA7105@fieldses.org>
Date:   Mon, 10 Jan 2022 09:16:21 +1100
Message-id: <164176658189.25899.1767614988647740830@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 07 Jan 2022, 'bfields@fieldses.org' wrote:
> On Thu, Jan 06, 2022 at 07:23:16AM +0000, inoguchi.yuki@fujitsu.com wrote:
> > > How about this?  I also updated the lock/nolock description and deleted
> > > the end of this subsection since it's redundant with that. And removed
> > > the bit about using nolock to mount /var with v2/v3 as that seems like a
> > > bit of a niche case at this point.  If we still want to document that, I
> > > think it belongs elsewhere.
> > 
> > Thank you so much for creating the patch!
> > 
> > For the most part I agree with you, but I feel unsafe to remove the part 
> > "using nolock to mount /var with v2/v3" even if it seems niche case. 
> > I'm also not sure if there is another suitable document to migrate it. 
> > 
> > Therefore, at the end of "lock/nolock" subsection ...
> 
> I could live with that.
> 
> Though the other reason I cut it was because I think it needs updates
> too and I wasn't sure exactly how to handle them.
> 
> The v4 case is more important and should probably be dealt with first.
> I think the answer there is just "don't mount /var over NFSv4", period.

Why not? An NFSv4 client has no business accessing anything in
/var/lib/nfs, so how can it cause a problem?

> 
> And maybe we should be more specific: the problem is with /var/lib/nfs,
> not all of /var.

According to "3.2. CLIENT STARTUP" section "C/" in the README that comes
with nfs-utils,
      statd should be run before any NFSv2 or NFSv3 filesystem is
      mounted with remote locking (i.e. without -o nolock).

so it is only fair to say "the problem is with /var/lib/nfs" if that is
a separate filesystem from /var.

Note that "-o nolock" should also be used for the root filesystem for
root-over-NFSv3, as that must be mounted before statd can be running.

Maybe that it how it should be explained in the man page:

  -o nolock should be used to mount any NFSv3 filesystems that are
   mounted before rpc.statd can be started, which can only be started
   after /var/lib/nfs is available.

NeilBrown
