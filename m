Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A0B3E3ECC
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Aug 2021 06:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhHIEU4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Aug 2021 00:20:56 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57922 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbhHIEUz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Aug 2021 00:20:55 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6AB3C21EF4;
        Mon,  9 Aug 2021 04:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628482834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tdKSDNL+pofpSnFf046QHB3TogSAInmiCBDTxi7b0R4=;
        b=WQKDVF22d58/+3BMKqmcrLG54rrXRkkAPNv4PpG3nZ1aSzSZUzgmgvuTRXQMb73ITNvbKy
        su3yPF/XMfPV6T4MaJ9wrg74/2uNHG7cACfQem1lJxbCdVmBIjryKLOTBV4wEIi/HGSx92
        ADL7afVJGjRYzBzqhncI9c6p6b4TGqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628482834;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tdKSDNL+pofpSnFf046QHB3TogSAInmiCBDTxi7b0R4=;
        b=5jrpDZb4X1vR3tkpCnQ45dMCT7L6jcwbf3P3Oom/D/YWMc3pNogANsQK5CrQRXI2LhCHX4
        yik4ZEb8e8fVuPAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C1D0313398;
        Mon,  9 Aug 2021 04:20:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Dg1THxCtEGHmCgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 09 Aug 2021 04:20:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "plambri@redhat.com" <plambri@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: cto changes for v4 atomic open
In-reply-to: <dfe4f6ad0420a67b9ae0f500324ba976d700642c.camel@hammerspace.com>
References: <DF3F94B7-F322-4054-952F-90CE02B442FE@redhat.com>,
 <ef395e52f3bb8d07dd7a39bb0a6dd6fb64a87a1c.camel@hammerspace.com>,
 <20210803203051.GA3043@fieldses.org>,
 <3feb71ab232b26df6d63111ee8226f6bb7e8dc36.camel@hammerspace.com>,
 <20210803213642.GA4042@fieldses.org>,
 <a1934e03e68ada8b7d1abf1744ad1b8f9d784aa4.camel@hammerspace.com>,
 <162803443497.32159.4120609262211305187@noble.neil.brown.name>,
 <08db3d70a6a4799a7f3a6f5227335403f5a148dd.camel@hammerspace.com>,
 <162803867150.32159.9013174090922030713@noble.neil.brown.name>,
 <ea79c8676bea627bb78c57e33199229e3cf27a9c.camel@hammerspace.com>,
 <162804062307.32159.5606967736886802956@noble.neil.brown.name>,
 <dfe4f6ad0420a67b9ae0f500324ba976d700642c.camel@hammerspace.com>
Date:   Mon, 09 Aug 2021 14:20:26 +1000
Message-id: <162848282650.22632.1924568027690604292@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 04 Aug 2021, Trond Myklebust wrote:
> On Wed, 2021-08-04 at 11:30 +1000, NeilBrown wrote:
> 
> Caching not a "best effort" attempt. The client is expected to provide
> a perfect reproduction of the data stored on the server in the case
> where there is no close-to-open violation.
> In the case where there are close-to-open violations then there are two
> cases:
> 
>    1. The user cares, and is using uncached I/O together with a
>       synchronisation protocol in order to mitigate any data+metadata
>       discrepancies between the client and server.
>    2. The user doesn't care, and we're in the standard buffered I/O
>       case.
> 
> 
> Why are you and Bruce insisting that case (2) needs to be treated as
> special?

I don't see these as the relevant cases.  They seem to assume that "the
user" is a single entity with a coherent opinion.  I don't think that is
necessarily the case.

I think it best to focus on the behaviours, and intentions behind,
individual applications.  You said previously that NFS doesn't provide
caches for applications, only for whole clients.  This is obviously true
but I think it misses an important point.  While the cache belongs to
the whole client, the "open" and "close" are performed by individual
applications.  close-to-open addresses what happens between a CLOSE and
an OPEN.

While it may be reasonable to accept that any application must depend on
correctness of any other application with write access to the file, it
doesn't necessary follow that any application can only be correct when
all applications with read access are well behaved.

If an application arranges, through some external means, to only open a
file after all possible writing application have closed it, then the NFS
caching should not get in the way for the application being able to read
anything that the other application(s) wrote.  This, it me, is the core
of close-to-open consistency.

Another application writing concurrently may, of course, affect the read
results in an unpredictable way.  However another application READING
concurrently should not affect an application which is carefully
serialised with any writers.

Thanks,
NeilBrown
