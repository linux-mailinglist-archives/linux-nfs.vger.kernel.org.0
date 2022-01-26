Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D5C49D4AE
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jan 2022 22:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbiAZVrP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Jan 2022 16:47:15 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:39540 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiAZVrO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Jan 2022 16:47:14 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 97A952190B;
        Wed, 26 Jan 2022 21:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643233633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wwCqNAVxFssHUfnlnuxxpwR9TPFlYyH2jf2XVNtnT3k=;
        b=XcJ6wQDzpBOy1x4jIYITW+mimSq+65AA2rIlCdcuhMUXo/A15G25KPOSfjCK3Fscw/oTrW
        tIgkdy0qS+Fnj00999XYRVyTsdVlVby1iDTlAmszREqXL3ERkxTsNLJrUrq/cGsY0iu1In
        Sp/PWuXgienf88BE1DEke01fQFkO/kk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643233633;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wwCqNAVxFssHUfnlnuxxpwR9TPFlYyH2jf2XVNtnT3k=;
        b=xO4XOLlbII9EwZlT1utYvMefWEYLl2bGeLCig45Ic1ejhDhW7Cgi8MDcDb4NvHLWQ9dwzm
        JNGlGC6CMWvonwBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9649213E3C;
        Wed, 26 Jan 2022 21:47:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3lIhFF7B8WHAQwAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 26 Jan 2022 21:47:10 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Christoph Hellwig" <hch@infradead.org>
Cc:     "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Anna Schumaker" <anna.schumaker@netapp.com>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Mel Gorman" <mgorman@suse.de>,
        "Christoph Hellwig" <hch@infradead.org>,
        "David Howells" <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/23] MM: extend block-plugging to cover all swap reads
 with read-ahead
In-reply-to: <Ye5UzEzvN8WWMNBn@infradead.org>
References: <164299573337.26253.7538614611220034049.stgit@noble.brown>,
 <164299611274.26253.13900771841681128440.stgit@noble.brown>,
 <Ye5UzEzvN8WWMNBn@infradead.org>
Date:   Thu, 27 Jan 2022 08:47:06 +1100
Message-id: <164323362698.5493.8309546969459514762@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 24 Jan 2022, Christoph Hellwig wrote:
> On Mon, Jan 24, 2022 at 02:48:32PM +1100, NeilBrown wrote:
> > Code that does swap read-ahead uses blk_start_plug() and
> > blk_finish_plug() to allow lower levels to combine multiple read-ahead
> > pages into a single request, but calls blk_finish_plug() *before*
> > submitting the original (non-ahead) read request.
> > This missed an opportunity to combine read requests.
> >=20
> > This patch moves the blk_finish_plug to *after* all the reads.
> > This will likely combine the primary read with some of the "ahead"
> > reads, and that may slightly increase the latency of that read, but it
> > should more than make up for this by making more efficient use of the
> > storage path.
> >=20
> > The patch mostly makes the code look more consistent.  Performance
> > change is unlikely to be noticeable.
>=20
> Looks good:
>=20
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks.
>=20
> > Fixes-no-auto-backport: 3fb5c298b04e ("swap: allow swap readahead to be m=
erged")
>=20
> Is this really a thing?
Maybe it should be.....
As I'm sure you guessed, I think it is valuable to record this
connection between commits, but I don't like it hasty automatic
backporting of patches where the (unknown) risk might exceed the (known)
value.  This is how I choose to state my displeasure.

Thanks,
NeilBrown
