Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76AC73B861B
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Jun 2021 17:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbhF3PPa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Jun 2021 11:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235539AbhF3PPa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Jun 2021 11:15:30 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF96C061756
        for <linux-nfs@vger.kernel.org>; Wed, 30 Jun 2021 08:13:01 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 3A52E64B9; Wed, 30 Jun 2021 11:13:00 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 3A52E64B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1625065980;
        bh=2HBZtmdYpeZI5CYvBUGOcZWxdo7J2wSubv5VyGD0w50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cDCpGDKpPqFeKKKuofXlijUMIGGtWpbKkFIGM+iPDNcOjbr8iUC70jyTfIwrWdFji
         i3fvNZpw3K0AcPAr/PpSI0+CWsSbVLDruwybzHzgNK1QdVrrulOl+b1bw+9EDTXigK
         B8oDrx2rah3CzbWTopnGPDs2ucRT/PuM23wKssYA=
Date:   Wed, 30 Jun 2021 11:13:00 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC 1/1] nfsd: Initial implementation of NFSv4 Courteous
 Server
Message-ID: <20210630151300.GB20229@fieldses.org>
References: <20210603181438.109851-1-dai.ngo@oracle.com>
 <20210628202331.GC6776@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628202331.GC6776@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jun 28, 2021 at 04:23:31PM -0400, J. Bruce Fields wrote:
> On Thu, Jun 03, 2021 at 02:14:38PM -0400, Dai Ngo wrote:
> > @@ -6875,7 +6947,12 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> >  	case -EAGAIN:		/* conflock holds conflicting lock */
> >  		status = nfserr_denied;
> >  		dprintk("NFSD: nfsd4_lock: conflicting lock found!\n");
> > -		nfs4_set_lock_denied(conflock, &lock->lk_denied);
> > +
> > +		/* try again if conflict with courtesy client  */
> > +		if (nfs4_set_lock_denied(conflock, &lock->lk_denied) == -EAGAIN && !retried) {
> > +			retried = true;
> > +			goto again;
> > +		}
> 
> Ugh, apologies, this was my idea, but I just noticed it only handles
> conflicts from other NFSv4 clients.

(Oh, and I only just *now* noticed that you'd already pointed out that
problem in an email I apparently stopped reading after the first
paragraph:

	https://lore.kernel.org/linux-nfs/c983218b-d270-bbae-71c5-b591bfbce473@oracle.com/

Sorry!)

--b.
