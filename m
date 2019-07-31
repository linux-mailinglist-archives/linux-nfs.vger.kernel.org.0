Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44AD07C0CB
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jul 2019 14:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfGaMLe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Jul 2019 08:11:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33818 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbfGaMLe (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 31 Jul 2019 08:11:34 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1E279308424C;
        Wed, 31 Jul 2019 12:11:34 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-120-110.rdu2.redhat.com [10.10.120.110])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EDE9119C70;
        Wed, 31 Jul 2019 12:11:33 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 998EC20BD0; Wed, 31 Jul 2019 08:11:33 -0400 (EDT)
Date:   Wed, 31 Jul 2019 08:11:33 -0400
From:   Scott Mayhew <smayhew@redhat.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] nfsd: add principal to the data being tracked by
 nfsdcld
Message-ID: <20190731121133.GQ4131@coeurl.usersys.redhat.com>
References: <20190730210847.9804-1-smayhew@redhat.com>
 <20190730215428.GB3544@fieldses.org>
 <20190730215654.GC3544@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730215654.GC3544@fieldses.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 31 Jul 2019 12:11:34 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 30 Jul 2019, J. Bruce Fields wrote:

> On Tue, Jul 30, 2019 at 05:54:28PM -0400, J. Bruce Fields wrote:
> > How does it fail when principals are longer?  Does it error out, or
> > treat two principals as equal if they agree in the first 1024 bytes?
> 
> I guess it's being compared against a string passed from gss-proxy?  We
> could also check for limits there.

I'm using cr_principal (servicetype@hostname) since it's set by both
gssproxy and rpc.svcgssd.  cr_raw_principal (servicetype/hostname@REALM)
is only set by gssproxy.

-Scott
> 
> --b.
