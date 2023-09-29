Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391CB7B3151
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Sep 2023 13:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjI2L0X (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Sep 2023 07:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjI2L0W (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Sep 2023 07:26:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72B11AE
        for <linux-nfs@vger.kernel.org>; Fri, 29 Sep 2023 04:26:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7A136218E8;
        Fri, 29 Sep 2023 11:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695986776;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0vw59bnk/Wrqb8vYCk/WCQsYBAd/HBqU1BvDPB688GI=;
        b=ILbLmxJzJMDsSDJlWv/DlRQXLUtMrhZC6FixwS1mvIdDie7MO2JXL8UFrTeoMpEiz/3Y4Y
        BfZc3A9n1fWjAOCadTHzFYwbfoyU2xwalZMcMVSIyaI1TBfecVucDmNMVkag4mFPTMXUEh
        Mj70XYn6J8m6iC5eSbqH4ZnqpBlGipQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695986776;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0vw59bnk/Wrqb8vYCk/WCQsYBAd/HBqU1BvDPB688GI=;
        b=c7/fKrT0p3sp0HQBwFwNj3BPgMzEQ/EFg7G2yPK38k15X0mhUQqK7yO6Jomz2PRIGltmSL
        oPgOkXpY5+tTEnBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CB61A13434;
        Fri, 29 Sep 2023 11:26:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FKZRLVe0FmWuQwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 29 Sep 2023 11:26:15 +0000
Date:   Fri, 29 Sep 2023 13:26:13 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] nfs_lib.sh: Set NFS 4.2 on TCP as the default
Message-ID: <20230929112613.GA379979@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20230721123852.1420080-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721123852.1420080-1-pvorel@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi all,

> Previously NFS 3 on UDP was the default, which leaded to test being
> skipped when tests run without parameters:

> TCONF: UDP support disabled on NFS server

> This does not have an effect when tests run properly via
> runtest/net.nfs, which specify parameters. It just safes typing
> -t tcp (and optionally -v 4.2) when one runs single test manually.

FYI patch merged.

Kind regards,
Petr

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi,

> I'm pretty sure, we don't want to have UDP as the default (besides
> skipped with TCONF it was acked by Jeff [1]). But I wonder if NFS 4.2 is
> the best as the default version. Maybe just 4 or 4.1?

> Kind regards,
> Petr

> [1] https://lore.kernel.org/ltp/e4d22ae6cefb34463ed7d04287ca9e81cd0949d8.camel@kernel.org/

>  testcases/network/nfs/nfs_stress/nfs_lib.sh | 4 ++--
...
> -VERSION=${VERSION:=3}
> +VERSION=${VERSION:=4.2}
>  NFILES=${NFILES:=1000}
> -SOCKET_TYPE="${SOCKET_TYPE:-udp}"
> +SOCKET_TYPE="${SOCKET_TYPE:-tcp}"
