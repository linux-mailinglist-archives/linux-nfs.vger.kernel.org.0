Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08D36D9EB8
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Apr 2023 19:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240036AbjDFR1L (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Apr 2023 13:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240064AbjDFR1F (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Apr 2023 13:27:05 -0400
Received: from phd-imap.ethz.ch (phd-imap.ethz.ch [129.132.80.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C7DA5E1
        for <linux-nfs@vger.kernel.org>; Thu,  6 Apr 2023 10:26:44 -0700 (PDT)
Received: from localhost (192-168-127-49.net4.ethz.ch [192.168.127.49])
        by phd-imap.ethz.ch (Postfix) with ESMTP id 4PspLw343Fz31;
        Thu,  6 Apr 2023 19:26:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phys.ethz.ch;
        s=2023; t=1680801976;
        bh=jxnYfwN8gmYu+P3g5db8LSZaRaw4ZDW9LOP3ZO3NCd8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=or94ud+6dGn7cZ2JjrL2kIodVvVZv1o0cK/mQnXOD/IXiW37j7/7ZbWqi9Ts3BTTj
         NOLDqMxgsQjm5RvHNHEwity0xcfU4CaZxGOBC0G1GAf0gECDYmo2qK4o+QvHhJJt1L
         82M0fvlNS4wui6B/C5epW30Jv8Aq6+rqGF0ogSMZHxedbM0j4TF41vEmuWkEZoG59N
         tSKPcqhu7yDU8LoJZeq4II229t0xzkQFG9UVzJzmNpxIghNvUuFyLmXASKOCLGX9si
         EInKOpl+Fk7ezpbym9FP0FdVdrUNsf7aMj6B/Nx8mm02DafhH+8Q7p+v1oh5VR1d7n
         DT0bSzhylg+IQ==
X-Virus-Scanned: Debian amavisd-new at phys.ethz.ch
Received: from phd-mxin.ethz.ch ([192.168.127.53])
        by localhost (phd-mailscan.ethz.ch [192.168.127.49]) (amavisd-new, port 10024)
        with LMTP id 9GTg0saUeQMs; Thu,  6 Apr 2023 19:26:16 +0200 (CEST)
Received: from phys.ethz.ch (mothership.ethz.ch [192.33.96.20])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: daduke@phd-mxin.ethz.ch)
        by phd-mxin.ethz.ch (Postfix) with ESMTPSA id 4PspLw2Dl2z9r;
        Thu,  6 Apr 2023 19:26:16 +0200 (CEST)
Date:   Thu, 6 Apr 2023 19:26:15 +0200
From:   Christian Herzog <herzog@phys.ethz.ch>
To:     Bob Ciotti <bob.ciotti@gmail.com>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bob Ciotti <bob.ciotti@nasa.gov>
Subject: Re: file server freezes with all nfsds stuck in D state after
 upgrade to Debian bookworm
Message-ID: <ZC8AtxuibSDwvK49@phys.ethz.ch>
Reply-To: Christian Herzog <herzog@phys.ethz.ch>
References: <ED825E99-1934-4F88-986E-2F1358D2D75A@oracle.com>
 <4F41FC87-908F-451F-8D2C-089CB7AB5919@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4F41FC87-908F-451F-8D2C-089CB7AB5919@gmail.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Dear Bob,

thanks a lot for your input.

> >>>> That was our first idea too, but we haven't found any indication that this is the case. The xfs file systems seem perfectly fine when all nfsds are in D state, and we can
> >>>> read from them and write to them. If xfs were to block nfs IO, this should
> >>>> affect other processes too, right?
> >>> It's possible that the NFSD threads are waiting on I/O to a particular filesystem block. XFS is not likely to block other activity in this case.
> >> ok good to know. So far we were under the impression that a file system would
> >> block as a whole.
> > 
> > XFS tries to operate in parallel as much as it can. Maybe other filesystems aren't as capable.
> > 
> > If the unresponsive block is part of a superblock or the journal (ie, shared metadata) I would expect XFS to become unresponsive. For I/O on blocks containing file data, it is likely to have more robust behavior.
> > 
> 
> Pretty sure we have seen a similar issue - never fully explained.  From what I recall, the server gets to a low memory state. At that point, efforts to coalesce writes are abandoned, and each write request is processed in line - vs scheduled - all nfsd's then pile up in D.  writes continue to arrive at a rate higher than can keep up. But, the back end store (a high end netapp raid 6 w/240 drives also with xfs) had very little load - not too busy.  Never fully explained it - but Chucks point on  shared metadata block may be good place to look - and whether in-line write at low memory could have synergy.  IIRC, worked around with releases and tunables like minfree kmem et.al. , that came into play to reduce - but not eliminate. I'm away from reference material for a while but I'll review and update if I find anything.
we'll certainly investigate this topic, but right now it's kinda hard to
imagine since I've never seen the file server above ~10G of its 64G of RAM
(excluding page cache of course). We're not even sure heavy writes trigger the
problem, in one case our monitoring hinted at a lot of reads leading up to the
freeze.
OTOH if our issue could be resolved by throwing a bunch of RAM bars into the
server, all the better.


thanks,
-Christian

