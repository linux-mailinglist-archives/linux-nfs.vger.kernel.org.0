Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C45453B38
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Nov 2021 21:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhKPUw0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Nov 2021 15:52:26 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36198 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhKPUw0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Nov 2021 15:52:26 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4748D1FD26;
        Tue, 16 Nov 2021 20:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637095768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DlVTCDCJmY1znxT2AOuLAvy2rN54GRSlo3nAW+bUxn8=;
        b=h8v9Ly0jiyVQYbuLUW/BRqPtnvDlIjfJ4ESMqmRAUjRZp6UXzqHpQ36MroGDd88FmnX5bW
        NRN2qhGN5hbaw5N9s4egjYgrponioDdsZQbKZT28kOEr/zM0d7OsBbWmwgtAbXWf8ATn5u
        vJr5Cpeeg4JQ2gwB7gFr1h49zNp8vs0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637095768;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DlVTCDCJmY1znxT2AOuLAvy2rN54GRSlo3nAW+bUxn8=;
        b=w2Aloo5DKpfAeLU78gVAcCFmHCLxx8vNNl1VU0zivTX4fwmJm4vptU+XUITjxE9ZU5UxkX
        J3XYyScuslcRwFCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 38D8D13C51;
        Tue, 16 Nov 2021 20:49:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yX4nOlYZlGEEbwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 16 Nov 2021 20:49:26 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Anna Schumaker" <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/3] Don't store cred in nfs_access_entry
In-reply-to: <163278643081.17728.10586733395858659759.stgit@noble.brown>
References: <163278643081.17728.10586733395858659759.stgit@noble.brown>
Date:   Wed, 17 Nov 2021 07:49:22 +1100
Message-id: <163709576284.13692.2252149084412844753@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Hi Trond/Anna,
 have you had a chance to look at these patches?

Thanks,
NeilBrown

On Tue, 28 Sep 2021, NeilBrown wrote:
> It turns out that storing a counted ref to 'struct cred' in
> nfs_access_entry wasn't a good choice.
> 'struct cred' contains counted references to 'struct key', and users
> have a quota on how many keys they can have.  Keeping a cred in a cache
> imposes on that quota.
> 
> The nfs access cache can keep a large number of entries, and keep them
> indefinitely.  This can cause a user to go over-quota.
> 
> This series removes the 'struct cred *' from nfs_access_entry and
> instead stores the uid, gid, and a pointer to the group info.
> This makes the nfs_access_entry 64 bits larger.
> 
> Thanks,
> NeilBrown
> 
> ---
> 
> NeilBrown (3):
>       NFS: change nfs_access_get_cached to only report the mask
>       NFS: pass cred explicitly for access tests
>       NFS: don't store 'struct cred *' in struct nfs_access_entry
> 
> 
>  fs/nfs/dir.c            | 63 ++++++++++++++++++++++++++++++++++-------
>  fs/nfs/nfs3proc.c       |  5 ++--
>  fs/nfs/nfs4proc.c       | 13 +++++----
>  include/linux/nfs_fs.h  |  6 ++--
>  include/linux/nfs_xdr.h |  2 +-
>  5 files changed, 67 insertions(+), 22 deletions(-)
> 
> --
> Signature
> 
> 
