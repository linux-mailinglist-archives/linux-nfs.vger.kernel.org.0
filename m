Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9D7453BED
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Nov 2021 22:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhKPVxQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Nov 2021 16:53:16 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:59992 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhKPVxQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Nov 2021 16:53:16 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BCE69218D5;
        Tue, 16 Nov 2021 21:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637099417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/gL7DBnCzzHBpZNy+wcyNtKZAKIyGR6LzGBNGBYRfKE=;
        b=VfHPUYIKrd/YymGiAVQcJATECW7/WvtAYOvtMVs9V1WwbsWIfV5IrEvtm1j605mkVWHg5j
        cKcBSF7MPngf4upF2w0PB/pMsx0MrWFL2eFjv8g71GykbOtafVM3ljKcHWXEAUMRC6L3Cf
        /XlHA8YFb2gMKz0b7lh1mlRgCVVfbEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637099417;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/gL7DBnCzzHBpZNy+wcyNtKZAKIyGR6LzGBNGBYRfKE=;
        b=ABuCVnbjJ59Pj6kogKNCLmQ0qsQOrNuUJ2vOufjBfhMxvvcXMc/rv14P9aKRdEyOUf2STH
        DmSOlX9VkOgErhBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1F70413C5E;
        Tue, 16 Nov 2021 21:50:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GnRnM5YnlGEFIgAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 16 Nov 2021 21:50:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Christoph Hellwig" <hch@infradead.org>
Cc:     "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Anna Schumaker" <anna.schumaker@netapp.com>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Mel Gorman" <mgorman@suse.de>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] NFS: do not take i_rwsem for swap IO
In-reply-to: <YZNjLtYKnQ/RFpxR@infradead.org>
References: <163702956672.25805.16457749992977493579.stgit@noble.brown>,
 <163703064452.25805.5738767545414940042.stgit@noble.brown>,
 <YZNjLtYKnQ/RFpxR@infradead.org>
Date:   Wed, 17 Nov 2021 08:50:12 +1100
Message-id: <163709941227.13692.8504638930849686895@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 16 Nov 2021, Christoph Hellwig wrote:
> I'd really much prefer the variant we discussed before where
> swap I/O uses it's own method instead of overloading the normal
> file I/O path all over.
> 
> 
This would be David Howells' "mm: Use DIO for swap and fix NFS
swapfiles" series?  I'd be very happy to work with that once it lands.
I might try it out and see how two work together.

Thanks,
NeilBrown
