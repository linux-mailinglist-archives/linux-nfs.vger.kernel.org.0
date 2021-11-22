Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBCB459863
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Nov 2021 00:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbhKVX2w (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Nov 2021 18:28:52 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:53546 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhKVX2w (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Nov 2021 18:28:52 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 32F26218F6;
        Mon, 22 Nov 2021 23:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637623544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1E0YuGxnUAcZpMw6uOKCWgD08nS2Xx8zFvQY9xcd8H8=;
        b=FqBlZG069tMztXHUTD2oIyo6Tkt2bhKNQhttW6XDsBqz9QEK8y8w1GwbBg64ukO9q9b/q6
        euRPtcbZC4OgLj+DxweNkOQjOxC2EUXBPdFhuvk6uJLSebq30yQ0b6MASJw682HxpC9220
        OwNVaGDapSBQeGhFI+aUCN62m1G/8gc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637623544;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1E0YuGxnUAcZpMw6uOKCWgD08nS2Xx8zFvQY9xcd8H8=;
        b=N6upfFtHtY47rSMSvjOwl+acLW2m/kAdEGJM0Uc8Uu0NmohfQEk515T1lrw4b8Xxz0qhXv
        dlEy9BLVlcf7ypAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 102F713BAB;
        Mon, 22 Nov 2021 23:25:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id khNpLvYmnGHKTQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 22 Nov 2021 23:25:42 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 00/14] SUNRPC: clean up server thread management.
In-reply-to: <20211122151823.GA22802@fieldses.org>
References: <163710954700.5485.5622638225352156964.stgit@noble.brown>,
 <20211117141231.GA24762@fieldses.org>,
 <163753863448.13692.4142092237119935826@noble.neil.brown.name>,
 <20211122005639.GA12035@fieldses.org>, <20211122005901.GB12035@fieldses.org>,
 <163754358887.13692.5665882865660886756@noble.neil.brown.name>,
 <20211122023753.GC12035@fieldses.org>, <20211122033840.GD12035@fieldses.org>,
 <20211122151823.GA22802@fieldses.org>
Date:   Tue, 23 Nov 2021 10:25:40 +1100
Message-id: <163762354003.7248.5982295057216919621@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 23 Nov 2021, J. Bruce Fields wrote:
> > 
> > Hm, playing with reproducer; it takes more than one mount.  My simplest
> > reproducer is:
> > 
> > 	mount -overs=3 server:/path /mnt/
> > 	umount /mnt/
> > 	mount -overs=4.0 server:/path /mnt/
> > 
> > ... and the client crashes here.
> 
> Also: the problem starts with the last patch ("lockd: use
> svc_set_num_threads() for thread start and stop").

That helps.  It points to lockd, and so to lockd stopping.
Lockd wasn't stopping for me because I had nfsd running.
I disabled nfsd and tried again - and got the crash.

The problem is 
#define svc_serv_is_pooled(serv)    ((serv)->sv_ops->svo_function)

Why does the presence of a svo_function mark the serv as being
'pooled'???

That last patch gave lockd an svo_function, so when threats were
stopped, the pool was released.  But as lockd doesn't create a pooled
service, the pool was never claimed.  So the pool_map->npools was set
to zero even though it should have still been active.
I'll probably change svc_serv_is_pooled() to test serv->sv_nrpools, and
allow that to be zero for non-pooled services.

Thanks for your testing help,
NeilBrown
