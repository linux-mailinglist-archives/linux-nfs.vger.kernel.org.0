Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F1E497898
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jan 2022 06:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241104AbiAXFf3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jan 2022 00:35:29 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:50028 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiAXFf3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jan 2022 00:35:29 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 351051F380;
        Mon, 24 Jan 2022 05:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643002528;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OTyPEQDRmkQ+qcAPzVDveelCYqDuxJTJRFqBr095D38=;
        b=j3/KALv4ndNRWJBl8lDzFTKaVLwjLhs2zwVHfRpqBvAkojo2ETZIbxWKxGh5fxz1p1rpnc
        Af8vpqTY/6WqoL+GhIFreujuciP4nIoyZZ96ojK1zJBXa3WE1VgdLYjWrSiXUJCxRmzTy7
        J6lqWAgGg5YyLx7ONlHQPooxMebcXhw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643002528;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OTyPEQDRmkQ+qcAPzVDveelCYqDuxJTJRFqBr095D38=;
        b=6kQFbu1FyhQJvxwF9kvQXbdKtD05MpH8mDUNoyKS2VmDM+hdZLQ5do3xEHaHBWykPKPDs1
        ZgU9D+RiiJV0FDDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 044D01331A;
        Mon, 24 Jan 2022 05:35:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ljVjOp867mGoYwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Mon, 24 Jan 2022 05:35:27 +0000
Date:   Mon, 24 Jan 2022 06:35:26 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org,
        Yongcheng Yang <yongcheng.yang@gmail.com>
Subject: Re: [PATCH 1/1] utils: Fix left debug info
Message-ID: <Ye46npjOSzvqdXc2@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220122180243.19355-1-pvorel@suse.cz>
 <67d7bba1-d4e5-00be-c198-8501df6e61e1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67d7bba1-d4e5-00be-c198-8501df6e61e1@redhat.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> Hey!

> This patch is pretty messed up.

> On 1/22/22 13:02, Petr Vorel wrote:
> > Patch for 497ffdf8 ('manpage: remove the no longer supported value
> > "vers2"') [1] didn't contain printf in exportfs.c (looks like debugging
> > info) and errno handling in stropts.c (maybe work on other patch) which
> > were applied. Thus removing it.
> Someone pointed it to me that  with 2 v3 auto-negotiation
> on the same mount the is error EPROTONOSUPPORT
> instead of EBUSY so this test
>      if (errno != EBUSY)
> 	errno = olderrno;

> seemed to work but unfortunately I can
> not find the patch/bz or thread we were
> communicating in... So I am going to
> remove the test until I get (or find) the
> official patch

Hi Steve,

thanks a lot for explanation.

Also not sure if it needs to be removed, but there are at least few places which
mention NFS version 2.

$ git grep -i nfs.version.2
utils/mountd/mountd.man:an NFS side protocol used by NFS version 2 [RFC1094] and NFS version 3 [RFC1813].
utils/mountd/mountd.man:can support both NFS version 2, 3 and 4. If the
utils/mountd/mountd.man:can support both NFS version 2 and the newer version 3.
utils/nfsstat/nfsstat.c:  -2                    Show NFS version 2 statistics\n\
utils/statd/sm-notify.man:For NFS version 2 and version 3, the
utils/statd/statd.man:For NFS version 2 [RFC1094] and NFS version 3 [RFC1813], the

Kind regards,
Petr

> Committed!

> thanks,

> steved.
