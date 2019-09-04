Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE40A943F
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Sep 2019 22:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730364AbfIDU6d (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Sep 2019 16:58:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56966 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbfIDU6d (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 4 Sep 2019 16:58:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 37BCD3CA04;
        Wed,  4 Sep 2019 20:58:33 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-121-35.rdu2.redhat.com [10.10.121.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F29160852;
        Wed,  4 Sep 2019 20:58:27 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 41E5F209F3; Wed,  4 Sep 2019 16:58:26 -0400 (EDT)
Date:   Wed, 4 Sep 2019 16:58:26 -0400
From:   Scott Mayhew <smayhew@redhat.com>
To:     Simo Sorce <simo@redhat.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/2] nfsd: add principal to the data being tracked by
 nfsdcld
Message-ID: <20190904205826.GH11980@coeurl.usersys.redhat.com>
References: <20190830162631.13195-1-smayhew@redhat.com>
 <A732539C-837A-4764-8281-C26E4203DE25@oracle.com>
 <4598a6617fcb0123fb8c5c19e0ed2e489b242bcf.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4598a6617fcb0123fb8c5c19e0ed2e489b242bcf.camel@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 04 Sep 2019 20:58:33 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 30 Aug 2019, Simo Sorce wrote:

> On Fri, 2019-08-30 at 12:32 -0400, Chuck Lever wrote:
> > Simo, any comments or questions?
> 
> Although it is unlikely, in most scenarios to have a principal name
> longer than 1024 characters, it is definitely not impossible, given the
> principal name for hosts is generally compose of 3 components:
> - a short service name
> - a fully qualified hostname
> - a realm name

Right now I'm using the svc_cred.cr_principal, which doesn't include
the realm.  The reason I chose that was because it's set by both
gssproxy and rpc.svcgssd.  I suppose I can check
svc_cred.cr_raw_princpal first and then fall back to
svc_cred.cr_principal.
> 
> The service name is generally "nfs" or "host" in the NFSv4 case,
> however the realm name can be arbitrarily large and usually is the
> capitalized domain name where the realm resides.
> 
> While thinking about this I wondered, why not simply hash (SHA-256 for
> example) the principal name and store the hash instead?
> 
> It will make the length fixed and uniform and probably often shorter
> than the real principal names, so saving space in the general case.
> 
> I am not against truncating to 1024, but a hash would be more elegant
> and correct.

I can do that.  Is there any reason I would want to convert the hash to
to a human-readable format (i.e. something that would match the
sha256sum command-line tool's output) or can I just use the raw buffer?
Note that if we wanted to print the hash in an error message or
something, I can just use printk's %*phN format specifier...

-Scott
> 
> Simo.
> 
> 
> > Patches can be found here:
> > 
> > https://marc.info/?l=linux-nfs&m=156718239314526&w=2
> > 
> > https://marc.info/?l=linux-nfs&m=156718239414527&w=2
> > 
> > 
> > > On Aug 30, 2019, at 12:26 PM, Scott Mayhew <smayhew@redhat.com> wrote:
> > > 
> > > At the spring bakeathon, Chuck suggested that we should store the
> > > kerberos principal in addition to the client id string in nfsdcld.  The
> > > idea is to prevent an illegitimate client from reclaiming another
> > > client's opens by supplying that client's id string.
> > > 
> > > The first patch lays some groundwork for supporting multiple message
> > > versions for the nfsdcld upcalls, adding fields for version and message
> > > length to the nfsd4_client_tracking_ops (these fields are only used for
> > > the nfsdcld upcalls and ignored for the other tracking methods), as well
> > > as an upcall to get the maximum version supported by the userspace
> > > daemon.
> > > 
> > > The second patch actually adds the v2 message, which adds the principal
> > > (actually just the first 1024 bytes) to the Cld_Create upcall and to the
> > > Cld_GraceStart downcall (which is what loads the data in the
> > > reclaim_str_hashtbl). I couldn't really figure out what the maximum length
> > > of a kerberos principal actually is (looking at krb5.h the length field in
> > > the struct krb5_data is an unsigned int, so I guess it can be pretty big).
> > > I don't think the principal will be that large in practice, and even if
> > > it is the first 1024 bytes should be sufficient for our purposes.
> > > 
> > > Scott Mayhew (2):
> > >  nfsd: add a "GetVersion" upcall for nfsdcld
> > >  nfsd: add support for upcall version 2
> > > 
> > > fs/nfsd/nfs4recover.c         | 332 +++++++++++++++++++++++++++-------
> > > fs/nfsd/nfs4state.c           |   6 +-
> > > fs/nfsd/state.h               |   3 +-
> > > include/uapi/linux/nfsd/cld.h |  37 +++-
> > > 4 files changed, 311 insertions(+), 67 deletions(-)
> > > 
> > > -- 
> > > 2.17.2
> > > 
> > 
> > --
> > Chuck Lever
> > 
> > 
> > 
> 
> -- 
> Simo Sorce
> RHEL Crypto Team
> Red Hat, Inc
> 
> 
> 
> 
