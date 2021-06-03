Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C15F39AEED
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jun 2021 01:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhFCX6u (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Jun 2021 19:58:50 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33192 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCX6u (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Jun 2021 19:58:50 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 160AB1FD30;
        Thu,  3 Jun 2021 23:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622764624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=olSVEqIcIxV/kg3fj718S43P/CqxJJRCjI7PHU+yd7g=;
        b=QKnIsdjwVU8JXJqoxmcI/ls3Zku3G7oqO6RicSsioQJxhzED8ZCX6cgVQBFI/SqOgh0xY/
        UB1rKbqXRPd4utwRFULBjAihGXXvq5ZX5QKRPZI13tpCam4nwWMG8SDfA/KNShQnMZ8nMv
        fUrzFB7BMFPlY6SeKvE5uXOmy4pKxRE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622764624;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=olSVEqIcIxV/kg3fj718S43P/CqxJJRCjI7PHU+yd7g=;
        b=hcpV1U7UQ9DYtxR8cltPzpbmYhfC0VErppEga5QQ5c1q/VP9Xi6qjNy85dTeoBeTj/Y1HK
        B0bHRQCur2G5kyAg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 755D0118DD;
        Thu,  3 Jun 2021 23:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622764624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=olSVEqIcIxV/kg3fj718S43P/CqxJJRCjI7PHU+yd7g=;
        b=QKnIsdjwVU8JXJqoxmcI/ls3Zku3G7oqO6RicSsioQJxhzED8ZCX6cgVQBFI/SqOgh0xY/
        UB1rKbqXRPd4utwRFULBjAihGXXvq5ZX5QKRPZI13tpCam4nwWMG8SDfA/KNShQnMZ8nMv
        fUrzFB7BMFPlY6SeKvE5uXOmy4pKxRE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622764624;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=olSVEqIcIxV/kg3fj718S43P/CqxJJRCjI7PHU+yd7g=;
        b=hcpV1U7UQ9DYtxR8cltPzpbmYhfC0VErppEga5QQ5c1q/VP9Xi6qjNy85dTeoBeTj/Y1HK
        B0bHRQCur2G5kyAg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id cox4Ck5suWCgIwAALh3uQQ
        (envelope-from <neilb@suse.de>); Thu, 03 Jun 2021 23:57:02 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Olga Kornievskaia" <olga.kornievskaia@gmail.com>
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 0/3] modify xprt state using sysfs
In-reply-to: <20210603225907.19981-1-olga.kornievskaia@gmail.com>
References: <20210603225907.19981-1-olga.kornievskaia@gmail.com>
Date:   Fri, 04 Jun 2021 09:56:59 +1000
Message-id: <162276461931.16225.7591153378472996760@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 04 Jun 2021, Olga Kornievskaia wrote:
> From: Olga Kornievskaia <kolga@netapp.com>
> 
> When a transport gets stuck, it is desired to be able to move the tasks
> that have been stuck/queued on that transport to another. 

This is interesting.....
A long-standing problem with NFS is that it is tricky to reliably
unmount a filesystem if the network is not responding.  It is possible,
but you need to identify all the processes blocked on the filesystem and
SIGKILL them.
My most recent exposure to this was when shutdown hung for someone
because NetworkManager shutdown the wifi before NFS filesystems were
unmounted.   This is arguably a config error, but the same problem could
happen with a power-outage instead of networkmanage breaking the wifi.

It would be nice to be able to forcibly unmount filesystems.  e.g.  mark
the transport as dead in such a way that all requests report EIO (or
similar).
This is obviously a big hammer, probably bigger than justified for use
with "umount -f", but sometimes it is a necessary hammer.

Could your work lead to being able to do this?  Could I write a shutdown
script that runs when there is no more network and no expectation of any
network ever again, and which marks all transports as dead - and then
wakes up all pending rpc tasks?

Thanks,
NeilBrown
