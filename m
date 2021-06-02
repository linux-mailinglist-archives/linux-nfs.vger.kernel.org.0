Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47E6398E53
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jun 2021 17:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbhFBPU0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Jun 2021 11:20:26 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57586 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbhFBPUO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Jun 2021 11:20:14 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E2AFE1FD9E;
        Wed,  2 Jun 2021 15:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622647110;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CDy6IX3UIOocuC+e49z4h7GWObpU0IDq+HoU9XpxzMg=;
        b=G35qeNILTVOEGpS7tMLTGCmb8yXUsmkBzkRtXlO6KwLOJsrgazCSvM+7lSy+ndfb7EzLfB
        AANHAhZv+8TWhFfbCC+NSmnify73xXcGSthoX3dViZyTEYxmGJi1TUi/Nrr4eUp40ERsbQ
        o9J5yUNscnXID4Fe64OjxWEtrj0rphU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622647110;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CDy6IX3UIOocuC+e49z4h7GWObpU0IDq+HoU9XpxzMg=;
        b=Ui7rmhhPmJ2NZnmpIvdwZLkQyzUtzjtTz71QzIBmnZ+28YctxjXEAtna9pDVVnr4aCgQRy
        LNOye4dpDMDUiNDg==
Received: by imap.suse.de (Postfix, from userid 51)
        id DB52311A98; Wed,  2 Jun 2021 15:28:32 +0000 (UTC)
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id C510011DC1;
        Wed,  2 Jun 2021 11:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622632094;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CDy6IX3UIOocuC+e49z4h7GWObpU0IDq+HoU9XpxzMg=;
        b=nwDRaeWZM97xux4C/TxkwjfYfXYj1Bfw4g4jjkktyeEusYom3aMkBIDbqrw3XURj2LlRtj
        ymgZuwvC8btQljmV4xjGXkqd6B9BTbvFyLbhEG/zK4nfGSMPFteCgyvB6g0zg01rlgmjqW
        VGyyFS+mdcgd5vaKq0BiT04NIc+PyyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622632094;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CDy6IX3UIOocuC+e49z4h7GWObpU0IDq+HoU9XpxzMg=;
        b=0FH2Ja176sGY5CNWJ/L+8TGmf6LSmwBR160OhgpPzF7hgCWYVFnv+iFj4ng4Gfu5/pCVyX
        e/+Oz3eeOdfwYzAw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id /DUqLp5mt2CaZgAALh3uQQ
        (envelope-from <pvorel@suse.cz>); Wed, 02 Jun 2021 11:08:14 +0000
Date:   Wed, 2 Jun 2021 13:08:13 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Cc:     ltp@lists.linux.it, linux-nfs@vger.kernel.org
Subject: Re: [LTP PATCH v2 1/3] nfs_lib.sh: Detect unsupported protocol
Message-ID: <YLdmnYAbxzADpqCU@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210526172503.18621-1-pvorel@suse.cz>
 <210e1e4f-23d8-6a8b-18cb-ea7a4e7f89c2@bell-sw.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <210e1e4f-23d8-6a8b-18cb-ea7a4e7f89c2@bell-sw.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> On 26.05.2021 20:25, Petr Vorel wrote:
> > Caused by disabled CONFIG_NFSD_V[34] in kernel config.

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > new in v2

> >  testcases/network/nfs/nfs_stress/nfs_lib.sh | 6 ++++++
> >  1 file changed, 6 insertions(+)

> > diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> > index 3fad8778a..b80ee0e18 100644
> > --- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
> > +++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> > @@ -94,9 +94,15 @@ nfs_mount()

> >  	if [ $? -ne 0 ]; then
> >  		cat mount.log
> > +
> >  		if [ "$type" = "udp" -o "$type" = "udp6" ] && tst_kvcmp -ge 5.6; then
> >  			tst_brk TCONF "UDP support disabled with the kernel config NFS_DISABLE_UDP_SUPPORT?"
> >  		fi
> > +
> > +		if grep -i "Protocol not supported" mount.log; then

> Hi Petr,

> It's better to add '-q' flag to grep.
Good point, thanks!

Kind regards,
Petr
