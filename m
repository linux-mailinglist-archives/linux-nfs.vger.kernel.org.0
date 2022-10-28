Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FD86106B7
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 02:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbiJ1ANd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Oct 2022 20:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbiJ1ANc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Oct 2022 20:13:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998D7836DD
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 17:13:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 49A71219B4;
        Fri, 28 Oct 2022 00:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666916010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oNPTg2XmTNh7CXx4owbb65ljCWD6oEyJZ6sm6RSZCO4=;
        b=begJEwMfD1vVUZmLWtr2hoKlc7eGOydYzSHt7Ol6wyhRUnNAu2yrMVGGb2pAgbq+FG3DnU
        We80O7A+MwSx60YXjfMyaMECzplH+/0vQnYQgwnu8GhEoiDj7tQIEvsBk1nj66ZmBGYf4M
        CtMbhIzkP7yVL3lrIQdqNphB6B0rvbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666916010;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oNPTg2XmTNh7CXx4owbb65ljCWD6oEyJZ6sm6RSZCO4=;
        b=lDg4beuW85az0k/mqtHwAd580c5Ze3oav0TbrLFjqkh0LmoKaOXOwJb4hXZy7yzIWk/run
        //RPUSFcFT5P+qBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 13C1313A37;
        Fri, 28 Oct 2022 00:13:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HAinLqgeW2OjKAAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 28 Oct 2022 00:13:28 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        "Jeff Layton" <jlayton@redhat.com>
Subject: Re: [PATCH v6 09/14] NFSD: Clean up nfsd4_init_file()
In-reply-to: <293CDB70-F274-425C-BB16-9276BCC48545@oracle.com>
References: <166689625728.90991.15067635142973595248.stgit@klimt.1015granger.net>,
 <166689675530.90991.2630847343462195612.stgit@klimt.1015granger.net>,
 <166691293591.13915.198182531468244072@noble.neil.brown.name>,
 <293CDB70-F274-425C-BB16-9276BCC48545@oracle.com>
Date:   Fri, 28 Oct 2022 11:13:13 +1100
Message-id: <166691599396.13915.21309745977669653@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 28 Oct 2022, Chuck Lever III wrote:
> 
> > On Oct 27, 2022, at 7:22 PM, NeilBrown <neilb@suse.de> wrote:
> > 
> > On Fri, 28 Oct 2022, Chuck Lever wrote:
> >> Name nfs4_file-related helpers consistently. There are already
> >> nfs4_file_yada functions, so let's go with the same convention used
> >> by put_nfs4_file(): init_nfs4_file().
> > 
> > I don't understand.  You say "consistently", then you say that as we
> > have lots of "nfs4_file_yada" functions, this new one will NOT follow
> > that pattern.
> 
> Patch description is admittedly terse.
> 
> I want a naming convention that sets apart the helpers that
> deal with the nfs4_file hash table. Maybe nfs4_file_hash_yada
> would be a better choice?
> 
> But we already have put_nfs4_file()...

OK, that makes more sense.  Thanks,

NeilBrown


> 
> 
> > Surely "consistency" means renaming put_nfs4_file() to nfs4_file_put(),
> > and introducing nfs4_file_init().
> > 
> > Not that I really care that much about the naming, but would like to be
> > able to follow your logic.
> > 
> > Thanks,
> > NeilBrown
> 
> --
> Chuck Lever
> 
> 
> 
> 
