Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C105A3C1BFA
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jul 2021 01:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhGHXZ7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Jul 2021 19:25:59 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45222 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhGHXZ6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 8 Jul 2021 19:25:58 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6E94B21EF1;
        Thu,  8 Jul 2021 23:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625786595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dxM1c9BhJWVt1uyGK7GAta4cNMJsWsrxFKFXFaQyZMw=;
        b=GKoj8FVZ45+gI1yMOaoY7chroA1Ekjx1I95wGrjnB07SZ2Y2R8lBDnE+H69TKj8cB8NWQZ
        kTpG64Xq3Gbb+kMQkSHfJPpZc8mIDtheWF3ShaDs5Q6CxD/mLCJj6+rg9yhcmXDiz7EEfj
        iTrow6laRP53AMrTiW/7cKa/JrBPtfY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625786595;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dxM1c9BhJWVt1uyGK7GAta4cNMJsWsrxFKFXFaQyZMw=;
        b=JBSliye15uCnPBkGqaPirLsOQ0zeqRO8QeWoklO82aUpjZ18QFljdzeWF8IrDaAF5guTOf
        4ZnBNknPNOdF5hAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2128513B21;
        Thu,  8 Jul 2021 23:23:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MN01MeGI52CudQAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 08 Jul 2021 23:23:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 0/3] Bulk-release pages during NFSD read splice
In-reply-to: <162575623717.2532.8517369487503961860.stgit@klimt.1015granger.net>
References: <162575623717.2532.8517369487503961860.stgit@klimt.1015granger.net>
Date:   Fri, 09 Jul 2021 09:23:10 +1000
Message-id: <162578659050.31036.16278478540386858207@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 09 Jul 2021, Chuck Lever wrote:
> 
> In this version of the series, each nfsd thread never accrues more
> than 16 pages. We can easily make that larger or smaller, but 16
> already reduces the rate of put_pages() calls to a minute fraction
> of what it was, and does not consume much additional space in struct
> svc_rqst.
> 
> Comments welcome!

Very nice.  Does "1/16" really count as "minute"? Or did I miss
something and it is actually a smaller fraction?
Either way: excellent work.

Reviewed-by: NeilBrown <neilb@suse.de>

NeilBrown

> 
> ---
> 
> Chuck Lever (3):
>       NFSD: Clean up splice actor
>       SUNRPC: Add svc_rqst_replace_page() API
>       NFSD: Batch release pages during splice read
> 
> 
>  fs/nfsd/vfs.c              | 20 +++++---------------
>  include/linux/sunrpc/svc.h |  5 +++++
>  net/sunrpc/svc.c           | 29 +++++++++++++++++++++++++++++
>  3 files changed, 39 insertions(+), 15 deletions(-)
> 
> --
> Chuck Lever
> 
> 
