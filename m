Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39822462250
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Nov 2021 21:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhK2Unh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Nov 2021 15:43:37 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52918 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbhK2Ulg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Nov 2021 15:41:36 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 36B9421763;
        Mon, 29 Nov 2021 20:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638218295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SROKhClUE5M+stT1rSAKj8ObPyk7ZGavo+PmTtzQKGI=;
        b=bKJ8g6XlP5qu0FHD4X6iVsaZr9VARAhFPtVBpuJZmXG0AtRaU9MQENkuHEHE35843s+gtX
        BPQUb+UR7lASc5oR1mD75SoInTAyLnS9k7bbn4k5tHjCwLiZbUu8gQKHuZzC6DAddHBzLe
        GGADrqimo+Lu7u7+FiuyJyZmjt422cE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638218295;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SROKhClUE5M+stT1rSAKj8ObPyk7ZGavo+PmTtzQKGI=;
        b=aCmmJi0KGyPzd+eFoMAEqOH48fGgyZkAp4pclHQ/Wwzsq6S2Ap1cOW3HQ4yRyMuusM/Och
        kDEwjwdvV03gv2Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 560A713BB8;
        Mon, 29 Nov 2021 20:38:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q7I+BDY6pWFnKAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 29 Nov 2021 20:38:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Steve Dickson" <steved@redhat.com>
Cc:     "Linux NFS Mailing list" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC 0/3] Remove NFS v2 support from the client and server
In-reply-to: <20211129192731.783466-1-steved@redhat.com>
References: <20211129192731.783466-1-steved@redhat.com>
Date:   Tue, 30 Nov 2021 07:38:10 +1100
Message-id: <163821829080.26075.9477835708436642432@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 30 Nov 2021, Steve Dickson wrote:
> These patches will remove the all references and 
> support of NFS v2 in both the server and client.

What is the motivation for this?
I don't necessarily disagree, but I'm curious as to what you hope to
gain.

Thanks,
NeilBrown

> 
> On server side the support has been off, by default, 
> since 2013 (6b4e4965a6b). With this server patch the
> ability to enable v2 will be remove.
> 
> Currently even with CONFIG_NFS_V2 not set
> v2 mounts are still tied (over-the-wire). I looked at creating 
> a kernel parameter module so support could re-enabled 
> but that got ugly quick.
> 
> So I just decided to make all V2 mounts fail with
> EOPNOTSUPP, with no way of turn them back on.
> 
> Steve Dickson (3):
>   nfsd: Remove the ability to enable NFS v2.
>   nfs.man: Remove references to NFS v2 from the man pages
>   mount: Remove NFS v2 support from mount.nfs
> 
>  nfs.conf                  |  1 -
>  utils/mount/configfile.c  |  2 +-
>  utils/mount/mount.nfs.man |  2 +-
>  utils/mount/network.c     |  4 ++--
>  utils/mount/nfs.man       | 20 +++-----------------
>  utils/mount/nfsmount.conf |  2 +-
>  utils/mount/stropts.c     |  3 +++
>  utils/nfsd/nfsd.c         |  2 --
>  utils/nfsd/nfsd.man       |  4 ++--
>  9 files changed, 13 insertions(+), 27 deletions(-)
> 
> -- 
> 2.31.1
> 
> 
