Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF3E3DF912
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Aug 2021 02:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbhHDA6J (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Aug 2021 20:58:09 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35454 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbhHDA6I (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Aug 2021 20:58:08 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 30BE6220F9;
        Wed,  4 Aug 2021 00:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628038676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2iqGxMnHm/QxYs7OHUI6RNP8L3x4sdHsx6v9fS4n5A4=;
        b=O8yqce/LCm9KMVo7u52i3y81scI3DfBOsMOv+sFc/KSrA9bX/LcbfMP325+XZsli0tsi2j
        6FmGfMbxyWwBzY9xiVFlda9sI48pVOUpnlCG4B+7KyKRDU2W8OiljqBCIXD5FHcXPxUGRR
        jaeAUSEhCe3R1a4HeYyA8oHA+PKFzcY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628038676;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2iqGxMnHm/QxYs7OHUI6RNP8L3x4sdHsx6v9fS4n5A4=;
        b=gYqxkpTe9ZTH0aop+JBkkPGGZb3C72O7FQL7BV1CRi1JEtOsJdzO/0AO9YthRit3HlEAA9
        KVOGeM1i4iVrcHCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 93A4D13B18;
        Wed,  4 Aug 2021 00:57:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LT+HFBLmCWFYIAAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 04 Aug 2021 00:57:54 +0000
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
In-reply-to: <08db3d70a6a4799a7f3a6f5227335403f5a148dd.camel@hammerspace.com>
References: <DF3F94B7-F322-4054-952F-90CE02B442FE@redhat.com>,
 <ef395e52f3bb8d07dd7a39bb0a6dd6fb64a87a1c.camel@hammerspace.com>,
 <20210803203051.GA3043@fieldses.org>,
 <3feb71ab232b26df6d63111ee8226f6bb7e8dc36.camel@hammerspace.com>,
 <20210803213642.GA4042@fieldses.org>,
 <a1934e03e68ada8b7d1abf1744ad1b8f9d784aa4.camel@hammerspace.com>,
 <162803443497.32159.4120609262211305187@noble.neil.brown.name>,
 <08db3d70a6a4799a7f3a6f5227335403f5a148dd.camel@hammerspace.com>
Date:   Wed, 04 Aug 2021 10:57:51 +1000
Message-id: <162803867150.32159.9013174090922030713@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 04 Aug 2021, Trond Myklebust wrote:
> 
> No. What you propose is to optimise for a fringe case, which we cannot
> guarantee will work anyway. I'd much rather optimise for the common
> case, which is the only case with predictable semantics.
> 

"predictable"??

As I understand it (I haven't examined the code) the current semantics
includes:
 If a file is open for read, some other client changed the file, and the
  file is then opened, then the second open might see new data, or might
  see old data, depending on whether the requested data is still in
  cache or not.

I find this to be less predictable than the easy-to-understand semantics
that Bruce has quoted:
  - revalidate on every open, flush on every close

I'm suggesting we optimize for fringe cases, I'm suggesting we provide
semantics that are simple, documentated, and predictable.

Thanks,
NeilBrown
