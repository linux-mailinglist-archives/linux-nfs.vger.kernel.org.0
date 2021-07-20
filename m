Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E444D3D050A
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jul 2021 01:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbhGTWav (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Jul 2021 18:30:51 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36130 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbhGTWas (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Jul 2021 18:30:48 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EAD0922409;
        Tue, 20 Jul 2021 23:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626822684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LN6PDSPL1OoRnGn+h0IFOeu/dQHz0x87XHv23gVNv24=;
        b=13HT43VhDO3J9HKLqc7vvsL6QX0PCpJP7LrIn7TvqYNLTVWjVDxapKqxJtbyOBfmozGFto
        wYzYJIye99TRrkNVE1xIES38XeO00pJ7pEiid/ZVma+17jKkTqpYNdWqVTmUFWjLdGuHMe
        Zc8Qkk3X7wi8UJHhjGEsmRJ44npqBIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626822684;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LN6PDSPL1OoRnGn+h0IFOeu/dQHz0x87XHv23gVNv24=;
        b=IxllSEQysOAwPKQcd48cmL2/FWCa0qe8dfzhdIWAgVoTCDNXyDT1OrdU2o5KTJX7SIMY8H
        Ja4Ich4ldB2NysBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7906C13B0C;
        Tue, 20 Jul 2021 23:11:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4gPvChlY92C4IQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 20 Jul 2021 23:11:21 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Christoph Hellwig" <hch@infradead.org>
Cc:     "Josef Bacik" <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, "Chris Mason" <clm@fb.com>,
        "David Sterba" <dsterba@suse.com>, linux-nfs@vger.kernel.org,
        "Wang Yugui" <wangyugui@e16-tech.com>,
        "Ulli Horlacher" <framstag@rus.uni-stuttgart.de>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH/RFC] NFSD: handle BTRFS subvolumes better.
In-reply-to: <YPaCuGm+3RX6vzjp@infradead.org>
References: <162632387205.13764.6196748476850020429@noble.neil.brown.name>,
 <edd94b15-90df-c540-b9aa-8eac89b6713b@toxicpanda.com>,
 <YPBmGknHpFb06fnD@infradead.org>,
 <28bb883d-8d14-f11a-b37f-d8e71118f87f@toxicpanda.com>,
 <YPBvUfCNmv0ElBpo@infradead.org>,
 <e1d9caad-e4c7-09d4-b145-5397b24e1cc7@toxicpanda.com>,
 <YPVC/w4kw3y/14oF@infradead.org>,
 <162673888433.4136.7451392112850411713@noble.neil.brown.name>,
 <YPZr9woK584Oc61H@infradead.org>,
 <162676543271.12554.10226255548215795177@noble.neil.brown.name>,
 <YPaCuGm+3RX6vzjp@infradead.org>
Date:   Wed, 21 Jul 2021 09:11:17 +1000
Message-id: <162682267778.12554.5231234508794819027@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 20 Jul 2021, Christoph Hellwig wrote:
> On Tue, Jul 20, 2021 at 05:17:12PM +1000, NeilBrown wrote:
> > Does anything there seem unreasonable to you?
> 
> This is what I've been asking for for years.
> 
> 
Execellent - we seem to be on the same page.
I'll aim to have some prelimiary patches for review within a week.

Thanks,
NeilBrown
