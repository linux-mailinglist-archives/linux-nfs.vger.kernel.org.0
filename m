Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADB2A97B7
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2019 02:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbfIEAuE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Sep 2019 20:50:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55844 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727789AbfIEAuD (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 4 Sep 2019 20:50:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C7315307D96D;
        Thu,  5 Sep 2019 00:50:03 +0000 (UTC)
Received: from ovpn-116-252.phx2.redhat.com (ovpn-116-252.phx2.redhat.com [10.3.116.252])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4302A5D71C;
        Thu,  5 Sep 2019 00:50:02 +0000 (UTC)
Message-ID: <90d43fc29c623aef70609bf02ef3eba54652c8ce.camel@redhat.com>
Subject: Re: [PATCH 0/2] nfsd: add principal to the data being tracked by
 nfsdcld
From:   Simo Sorce <simo@redhat.com>
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Wed, 04 Sep 2019 20:50:01 -0400
In-Reply-To: <20190904205826.GH11980@coeurl.usersys.redhat.com>
References: <20190830162631.13195-1-smayhew@redhat.com>
         <A732539C-837A-4764-8281-C26E4203DE25@oracle.com>
         <4598a6617fcb0123fb8c5c19e0ed2e489b242bcf.camel@redhat.com>
         <20190904205826.GH11980@coeurl.usersys.redhat.com>
Organization: Red Hat, Inc.
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 05 Sep 2019 00:50:03 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2019-09-04 at 16:58 -0400, Scott Mayhew wrote:
> > While thinking about this I wondered, why not simply hash (SHA-256 for
> > example) the principal name and store the hash instead?
> > 
> > It will make the length fixed and uniform and probably often shorter
> > than the real principal names, so saving space in the general case.
> > 
> > I am not against truncating to 1024, but a hash would be more elegant
> > and correct.
> 
> I can do that.  Is there any reason I would want to convert the hash to
> to a human-readable format (i.e. something that would match the
> sha256sum command-line tool's output) or can I just use the raw buffer?
> Note that if we wanted to print the hash in an error message or
> something, I can just use printk's %*phN format specifier...

I do not see a reason to waste time turning to ascii before the time
you really need to. A byte buffer is perfectly fine.

Simo.

-- 
Simo Sorce
RHEL Crypto Team
Red Hat, Inc




