Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7AAA3B1E46
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Jun 2021 18:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhFWQJF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Jun 2021 12:09:05 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46950 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWQJF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Jun 2021 12:09:05 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C87AA2195D;
        Wed, 23 Jun 2021 16:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624464406;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1MdPPUN/EDcPjkplXBAIfTOP3fh5nqKB/znLE3+1lnI=;
        b=D3zBY3KcBViepTJDnJZl4aiiw5iV1tcAZLJ8BePlB5ODa4Zh0d9UQ0HqC47hznVDdx4PQW
        VTMbiQB871sCPQs9Z0lDhB2fWoP84Z9i5aaFW3dxgIPbj9O7HA3/pXz24ttfKjNW+ez0LL
        +UTiaCAR0o5aiLh2VMfT3SqN89w1wJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624464406;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1MdPPUN/EDcPjkplXBAIfTOP3fh5nqKB/znLE3+1lnI=;
        b=SjH31SRB76Z2lIVZ8TnVhUg5xcXzyENGJ+Y4+8gEml3g+mqrebJ3ryUiqIrG8eqb5BImXW
        DSuL600zFY3PW/BA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 75ED911A97;
        Wed, 23 Jun 2021 16:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624464406;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1MdPPUN/EDcPjkplXBAIfTOP3fh5nqKB/znLE3+1lnI=;
        b=D3zBY3KcBViepTJDnJZl4aiiw5iV1tcAZLJ8BePlB5ODa4Zh0d9UQ0HqC47hznVDdx4PQW
        VTMbiQB871sCPQs9Z0lDhB2fWoP84Z9i5aaFW3dxgIPbj9O7HA3/pXz24ttfKjNW+ez0LL
        +UTiaCAR0o5aiLh2VMfT3SqN89w1wJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624464406;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1MdPPUN/EDcPjkplXBAIfTOP3fh5nqKB/znLE3+1lnI=;
        b=SjH31SRB76Z2lIVZ8TnVhUg5xcXzyENGJ+Y4+8gEml3g+mqrebJ3ryUiqIrG8eqb5BImXW
        DSuL600zFY3PW/BA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id vo2BGRZc02CsFwAALh3uQQ
        (envelope-from <pvorel@suse.cz>); Wed, 23 Jun 2021 16:06:46 +0000
Date:   Wed, 23 Jun 2021 18:06:44 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     James Dong =?utf-8?B?KOiRo+S4luaxnyk=?= <dongshijiang@inspur.com>
Cc:     "ltp@lists.linux.it" <ltp@lists.linux.it>,
        Alexey Kodanev <aleksei.kodanev@bell-sw.com>,
        Steve Dickson <SteveD@redhat.com>,
        "libtirpc-devel@lists.sourceforge.net" 
        <libtirpc-devel@lists.sourceforge.net>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [LTP] [PATCH] fix rpc_suite/rpc:add check returned value
Message-ID: <YNNcFHTRmBtviT+Y@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <52e4b3cba7d74f17b64816acaf50be01@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52e4b3cba7d74f17b64816acaf50be01@inspur.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Dong,

> Hi Petr
> I think this is just a simple test of some APIs, but some test cases are not standardized and cause errors like "Segmentation fault" during testing. I think it is necessary to fix these errors or delete these tests.

Sure this fix can get in. I saw issues with some tests on openSUSE, but that's a
separate problem (I was not able to find the problem thus report it.

> Kind regards,
> Dong

> > +++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svc_destroy/rpc_svc_destroy.c
> > @@ -46,6 +46,11 @@ int main(void)

> >  	//First of all, create a server
> >  	svcr = svcfd_create(fd, 0, 0);
> > +
> > +	//check returned value
> > +	if ((SVCXPRT *) svcr == NULL) {
IMHO casting is not required, right? Just
	if (svcr == NULL) {

Kind regards,
Petr
