Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6223F9037
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Aug 2021 23:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbhHZVjE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Aug 2021 17:39:04 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37172 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbhHZVjE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Aug 2021 17:39:04 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3E1411FEB7;
        Thu, 26 Aug 2021 21:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630013895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SOJseXPlIKJRKLonkGuEl1oFee5wUAgB0Q05HXQ2Ai0=;
        b=lcsF1EECKTQ0MGIMED095QnH0auhcHTQvIwyGgV7CtUKw/Cp+3B/a9OiJ/VcUl3wgqUczh
        qrWG08qkg+0tLqNLNUPHWTLZ4U7rM/cut5yPYL3gay2d9LmVF5LnfrdREAdoNwXRe2dBZ3
        6XNkACU81DfhOdnNWizVHOTOofcCnHw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630013895;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SOJseXPlIKJRKLonkGuEl1oFee5wUAgB0Q05HXQ2Ai0=;
        b=2uoFcNYSz8zDAXRksViYmZAseklcrfScreNRpj118/DkLzUfCZmccBJFk6FN1g/bstnZjH
        Nf019WdqXy2+ftBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BEC3413CF8;
        Thu, 26 Aug 2021 21:38:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HNx7HcUJKGG1awAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 26 Aug 2021 21:38:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Bruce Fields" <bfields@fieldses.org>,
        "Christoph Hellwig" <hch@lst.de>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFSD: drop support for ancient file-handles
In-reply-to: <BDD839B0-7837-4421-940B-6DB9EC31043E@oracle.com>
References: <162995209561.7591.4202079352301963089@noble.neil.brown.name>,
 <BDD839B0-7837-4421-940B-6DB9EC31043E@oracle.com>
Date:   Fri, 27 Aug 2021 07:38:10 +1000
Message-id: <163001389048.7591.12518735969639627593@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 27 Aug 2021, Chuck Lever III wrote:
> 
> > On Aug 26, 2021, at 12:28 AM, NeilBrown <neilb@suse.de> wrote:
> > 
> > 
> > File-handles not in the "new" or "version 1" format have not been handed
> > out for new mounts since Linux 2.4 which was released 20 years ago.
> > I think it is safe to say that no such file handles are still in use,
> > and that we can drop support for them.
> > 
> > This patch also moves the nfsfh.h from the include/uapi directory into
> > fs/nfsd.  I can find no evidence of it being used anywhere outside the
> > kernel.  Certainly nfs-utils and wireshark do not use it.
> > 
> > fh_base and fh_pad are occasionally used to refer to the whole
> > filehandle.  These are replaced with "fh_raw" which is hopefully more
> > meaningful.
> > 
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> > 
> > I found
> > https://www.spinics.net/lists/linux-nfs/msg43280.html
> > "Re: [PATCH] nfsd: clean up fh_auth usage"
> > from 2014 where moving nfsfh.h out of uapi was considered but not
> > actioned. Christoph said he would "do some research if the
> > uapi <linux/nfsd/*.h> headers are used anywhere at all".  I can find no
> > report on the result of that research.  My own research turned up
> > nothing.
> > 
> > Thanks,
> > NeilBrown
> 
> Hi Neil-
> 
> I have no philosophical objection to this clean up, but I'm
> concerned a bit about timing. It's a large patch, and 5.15
> should be opening on Sunday. I would prefer this to go into
> 5.16, if that's OK with you?

No problem at all.  I enjoy the luxury of send patches whenever I'm
ready, and assume you will process them only when you are ready.  I do,
of course, appreciate knowing what you plan.

Thanks,
NeilBrown
