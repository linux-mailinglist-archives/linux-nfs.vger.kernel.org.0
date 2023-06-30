Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9067432D1
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jun 2023 04:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjF3Cmo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jun 2023 22:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjF3Cmn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Jun 2023 22:42:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724F4273B
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 19:42:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1C2721F747;
        Fri, 30 Jun 2023 02:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688092961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eozCOHF379/U7P4CMNnMXBdKk0ejFm1RduA5sJdcsio=;
        b=jAaDK47Ewl4qdZPwH9HZR1yuczzw1Hbd6bTIi4CsW0vzV7qKAsH0FFmdzXkE8eJ2CI4Nz3
        lxLHaNAxPKqzxGLfx9lvMVg9Ofl/uoAJPz0ol6nx2f/OSeVuCZfPW0GSeVNBPQRCVPd6LW
        8DI8DgGyK7bz5GtyN6EAhy/cjWMI9EQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688092961;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eozCOHF379/U7P4CMNnMXBdKk0ejFm1RduA5sJdcsio=;
        b=mRJpbf4ElSXK4TvGHNV44AP3ZSHf+RkHFtVhxRE/sE5qS4DJlNs4wWwHDKfNaxjka4jF+g
        pqxwc8Lr4GQdUJBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DAE541391D;
        Fri, 30 Jun 2023 02:42:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XcqtIh5BnmTIRgAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 30 Jun 2023 02:42:38 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <cel@kernel.org>
Cc:     linux-nfs@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>,
        lorenzo@kernel.org, jlayton@redhat.com, david@fromorbit.com
Subject: Re: [PATCH RFC 0/8] RPC service thread scheduler optimizations
In-reply-to: <168806401782.1034990.9686296943273298604.stgit@morisot.1015granger.net>
References: <168806401782.1034990.9686296943273298604.stgit@morisot.1015granger.net>
Date:   Fri, 30 Jun 2023 12:42:35 +1000
Message-id: <168809295522.9283.8453285193952262503@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 30 Jun 2023, Chuck Lever wrote:
> Hi -
> 
> Walking a linked list to find an idle thread is not CPU cache-
> friendly, and in fact I've noted palpable per-request latency
> impacts as the number of nfsd threads on the server increases.
> 
> After discussing some possible improvements with Jeff at LSF/MM,
> I've been experimenting with the following series. I've measured an
> order of magnitude latency improvement in the thread lookup time,
> and have managed to keep the whole thing lockless.
> 
> The only thing I don't like is that allocating the idle bitmaps in
> advance means we've got an /a priori/ cap on the number of NFSD
> threads that can be created. I'd love to find a way to enable
> the pool idle bitmaps to expand dynamically. Suggestions welcome.

Hi Chuck,
 The series looks good.  I did notice that patch 6/8 used UINT_MAX and
 U32_MAX in different places for the same number, though the next patch
 replaced them both for a new number - the same in both places now.

 I agree that an a priori cap on number of threads is not ideal.
 Have you considered using the xarray to only store busy threads?
 I think its lookup mechanism mostly relies on a bitmap of present
 entries, but I'm not completely sure.

 That would require some extra work for svc_stop_threads() which is the
 only place we are interested in threads that aren't busy.  We would
 need to record a target number of threads, and whenever a thread
 becomes idle it checks if the number is exceeded.  If so it exits
 decrementing the number of threads, other wise it re-inserts into the
 xa (if it cannot find a transport to handle).

 Alternately we could store bitmaps as values in an xarray, much like
 the ida code does.

Thanks,
NeilBrown
