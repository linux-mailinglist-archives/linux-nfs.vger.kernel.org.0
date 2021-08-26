Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2BA3F903A
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Aug 2021 23:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbhHZVmm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Aug 2021 17:42:42 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37332 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbhHZVmm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Aug 2021 17:42:42 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E130C1FEBA;
        Thu, 26 Aug 2021 21:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630014113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SyCNeknivgOMTt7KbADb+EtCxWbc1zuSvZqDtRyoOHU=;
        b=VK1ZhHHXgQrQw3W2jCKpUymyNUwHnaqGViSppzC4NGHqBVI48xzVhcXhhlgiBAPE64sym6
        jJl83UP0+quQRnBbRtP2mmR9dVjOhV/xfDvkcXZsCeHZK/ot6Glf+sNDEfsYWHioxuMuWn
        TlHIkQi4Ql2eMFEyQU/h8khOkH4fAl4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630014113;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SyCNeknivgOMTt7KbADb+EtCxWbc1zuSvZqDtRyoOHU=;
        b=rIOj3DVvHnqE/xAPpoJ9/n92MQbZVc4sfQ2qg6o8mzEIMXkvLaloKDm3ErPR9Vbp4RrXPx
        1NNgpnthrnOJS5Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9326B13CF8;
        Thu, 26 Aug 2021 21:41:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hGViFKAKKGGPbAAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 26 Aug 2021 21:41:52 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "J.  Bruce Fields" <bfields@fieldses.org>
Cc:     "Chuck Lever" <chuck.lever@oracle.com>,
        "Christoph Hellwig" <hch@lst.de>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFSD: drop support for ancient file-handles
In-reply-to: <20210826145129.GA3616@fieldses.org>
References: <162995209561.7591.4202079352301963089@noble.neil.brown.name>,
 <20210826145129.GA3616@fieldses.org>
Date:   Fri, 27 Aug 2021 07:41:49 +1000
Message-id: <163001410955.7591.12537036452359700992@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 27 Aug 2021, J.  Bruce Fields wrote:
> On Thu, Aug 26, 2021 at 02:28:15PM +1000, NeilBrown wrote:
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
> 
> Oh boy, I will not miss those (fh_version == 1) cases in nfsfh.c.
> Excellent.

:-)

> 
> Looks like it just needs the following folded in.

Don't know how I missed those - so happy to have reliable reviewers!

Thanks,
NeilBrown
