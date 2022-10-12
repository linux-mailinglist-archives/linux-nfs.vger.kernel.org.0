Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0975FC0E0
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Oct 2022 08:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiJLGpn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Oct 2022 02:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiJLGpl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Oct 2022 02:45:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718B75F13E
        for <linux-nfs@vger.kernel.org>; Tue, 11 Oct 2022 23:45:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9180E22529;
        Wed, 12 Oct 2022 06:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1665557138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ojVOOCMXKAi8o5axDw6bSCWlRhgmjsxhm4rzRLjQdS8=;
        b=wBP439VTZ04PmyPij80BpmTp4nIpetCte//1J1+/YYxjGBqLxn0JoBuuMlC1FfPHyScb2O
        fBcBrNi2ISAPeic6i8yzA0RPDcSEHGCZJssT3afPXMlzTRT1IXgRnQw/gDh5WGm59dJ72u
        ZS9U5gpMuoOOoGK2dxH/G+Yf6UOPwGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1665557138;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ojVOOCMXKAi8o5axDw6bSCWlRhgmjsxhm4rzRLjQdS8=;
        b=V4EzQ9/RYl1LGkcIAXvcC7LZ92n7IgX8IJV4dAZTQMATHA/J8JUghSePCtKkRbozS2HuGh
        mgLAmSbBZJswqKCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E9DF13A5C;
        Wed, 12 Oct 2022 06:45:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xfLjFJFiRmPXLAAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 12 Oct 2022 06:45:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 7/9] NFSD: Use rhashtable for managing nfs4_file objects
In-reply-to: <EB08B095-BF02-4B5E-8CD2-12B0201328D2@oracle.com>
References: <166507275951.1802.13184584115155050247.stgit@manet.1015granger.net>,
 <166507324882.1802.884870684212914640.stgit@manet.1015granger.net>,
 <166544739751.14457.9018300177489236723@noble.neil.brown.name>,
 <EB08B095-BF02-4B5E-8CD2-12B0201328D2@oracle.com>
Date:   Wed, 12 Oct 2022 17:45:34 +1100
Message-id: <166555713439.32740.4569758527894347740@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 11 Oct 2022, Chuck Lever III wrote:
> > On Oct 10, 2022, at 8:16 PM, NeilBrown <neilb@suse.de> wrote:
> > 
> > On Fri, 07 Oct 2022, Chuck Lever wrote:
> >> 
> >> -static unsigned int file_hashval(struct svc_fh *fh)
> >> +/*
> >> + * The returned hash value is based solely on the address of an in-code
> >> + * inode, a pointer to a slab-allocated object. The entropy in such a
> >> + * pointer is concentrated in its middle bits.
> > 
> > I think you need more justification than that for throwing away some of
> > the entropy, even if you don't think it is much.
> 
> We might have that justification:
> 
> https://lore.kernel.org/linux-nfs/YrUFbLJ5uVbWtZbf@ZenIV/
> 
> Actually I believe we are not discarding /any/ entropy in
> this function. The bits we discard are invariant.
> 
> And, note that this is exactly the same situation we just merged
> in the filecache overhaul, and is a common trope amongst other
> hash tables that base their function on the inode's address.

Common?  I searched for ">> *L1_CACHE_SHIFT".  Apart from the nfsd
filecache you mentioned I find two.  One in quota and one in reiserfs.
Both work with traditional hash tables which are more forgiving of
longer chains.
Do you have other evidence of this being a common trope?

Thanks,
NeilBrown
