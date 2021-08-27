Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539583FA1AE
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Aug 2021 01:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbhH0XGE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Aug 2021 19:06:04 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:32978 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbhH0XGD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Aug 2021 19:06:03 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1A8DF1FF4B;
        Fri, 27 Aug 2021 23:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630105513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SZdODqQDlDyOqv2uAa/LVlgdI5QGPPQH1/ft+u8krO0=;
        b=HolJJ1R2gr8anL5O+U3086zJmU23s/pTtxvrYuJ/wBBJgQNN76+jwZyMZryONmZLqW6GTG
        hZJhMOqHzZEPgseVvCp4V8yz1TDxzBg0XN/fJz0gbLMgQY7X+J11uVgy7xjipk34w5+T5q
        oQS1azS60HGNFWFHsjLeEbJ/6rvDBKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630105513;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SZdODqQDlDyOqv2uAa/LVlgdI5QGPPQH1/ft+u8krO0=;
        b=RLfRk13GbUAbqQigvgoVyUTjBn4ux41JDqjt4K5OJLSjCJoZQG1I24iAVZaf2oWD3IeUIK
        8bDq0dm70nMZF3Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 71F0013D7D;
        Fri, 27 Aug 2021 23:05:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DrNZDKdvKWF6JQAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 27 Aug 2021 23:05:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Christoph Hellwig" <hch@infradead.org>
Cc:     "J.  Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        "Josef Bacik" <josef@toxicpanda.com>
Subject: Re: [PATCH v2] BTRFS/NFSD: provide more unique inode number for btrfs export
In-reply-to: <YSkQ31UTVDtBavOO@infradead.org>
References: <162995209561.7591.4202079352301963089@noble.neil.brown.name>,
 <162995778427.7591.11743795294299207756@noble.neil.brown.name>,
 <YSkQ31UTVDtBavOO@infradead.org>
Date:   Sat, 28 Aug 2021 09:05:08 +1000
Message-id: <163010550851.7591.9342822614202739406@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 28 Aug 2021, Christoph Hellwig wrote:
> On Thu, Aug 26, 2021 at 04:03:04PM +1000, NeilBrown wrote:
> > 
> > This patch allows btrfs (or any filesystem) to provide a 64bit number
> > that can be xored with the inode number to make the number more unique.
> > Rather than the client being certain to see duplicates, with this patch
> > it is possible but extremely rare.
> 
> Yikes.  Please don't do something like this that will eventually
> cause collisions.
> 
> 

There doesn't seem to be any other option - and this is still an
improvement over the current behaviour.

Collisions should still be quite a few years away, and there is hope
that the btrfs developers will take action before then to provide some
certainty.   Not much hope, but some.

NeilBrown
