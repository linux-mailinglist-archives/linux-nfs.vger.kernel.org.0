Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0B5453BE0
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Nov 2021 22:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhKPVtT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Nov 2021 16:49:19 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37832 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhKPVtS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Nov 2021 16:49:18 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 54BE31FD37;
        Tue, 16 Nov 2021 21:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637099180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c/L9KoKoaxSnL1Jn59yhmyWCrQE61s5MuhLMctoNPdU=;
        b=RgzNBBALsJ0q2yi+k2olZ09hFBSCYQFALEp/JjAQDq4nLpSfYjvvHEg/Rm9JLSsbPvmYIs
        X1evb7fGBb8VJfZEYPFkOMAiTGB3YXTFqpRDKvTtVMmoYY0R7t2eFXRqWtnrXdxxnMfzkg
        7IG93MR8RpuFfCBsFoXHmz4cMLRBtpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637099180;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c/L9KoKoaxSnL1Jn59yhmyWCrQE61s5MuhLMctoNPdU=;
        b=e+eCzDrgx+fAWEyBwRLIBGiZi7tt3MdyveQGsQYTzDZEZFb0WOrqhV0aryshHyw5hHZAhx
        tDlLcC5pWj2rVHAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 70BAB13C5E;
        Tue, 16 Nov 2021 21:46:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id C1WzC6kmlGG1IAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 16 Nov 2021 21:46:17 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Christoph Hellwig" <hch@infradead.org>
Cc:     "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Anna Schumaker" <anna.schumaker@netapp.com>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Mel Gorman" <mgorman@suse.de>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 12/13] MM: use AIO/DIO for reads from SWP_FS_OPS swap-space
In-reply-to: <YZNsf5yvfb8+SiqB@infradead.org>
References: <163702956672.25805.16457749992977493579.stgit@noble.brown>,
 <163703064458.25805.6777856691611196478.stgit@noble.brown>,
 <YZNsf5yvfb8+SiqB@infradead.org>
Date:   Wed, 17 Nov 2021 08:46:14 +1100
Message-id: <163709917463.13692.6685266362531701682@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 16 Nov 2021, Christoph Hellwig wrote:
> On Tue, Nov 16, 2021 at 01:44:04PM +1100, NeilBrown wrote:
> > When pages a read from SWP_FS_OPS swap-space, the reads are submitted as
> > separate reads for each page.  This is generally less efficient than
> > larger reads.
> >=20
> > We can use the block-plugging infrastructure to delay submitting the
> > read request until multiple contigious pages have been collected.  This
> > requires using ->direct_IO to submit the read (as ->readpages isn't
> > suitable for swap).
>=20
> Abusing the block code here seems little ugly.  Also this won't
> compile if CONFIG_BLOCK is not set, will it?

There is nothing really block-layer-specific about the plugging
interfaces.  I think it would be quite reasonable to move them to lib/
But you are correct that currently without CONFIG_BLOCK the code will
compile but not work.

>=20
> What is the problem with just batching up manually?

That would require a bigger change to common code, which would only
benefit one user.  The plugging mechanism works well for batching
requests to a block device.  Why not use it for non-block-devices too?

Thanks,
NeilBrown


>=20
> > +	/* nofs needs as ->direct_IO may take the same mutex it takes for write=
 */
>=20
> Overly long line.
>=20
>=20
