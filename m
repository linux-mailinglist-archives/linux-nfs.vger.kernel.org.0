Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0220AA3E13
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2019 21:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfH3TA6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Aug 2019 15:00:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53272 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727891AbfH3TA5 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 30 Aug 2019 15:00:57 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 89413C059B7C;
        Fri, 30 Aug 2019 19:00:57 +0000 (UTC)
Received: from ovpn-118-39.phx2.redhat.com (ovpn-118-39.phx2.redhat.com [10.3.118.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FB131001284;
        Fri, 30 Aug 2019 19:00:55 +0000 (UTC)
Message-ID: <4598a6617fcb0123fb8c5c19e0ed2e489b242bcf.camel@redhat.com>
Subject: Re: [PATCH 0/2] nfsd: add principal to the data being tracked by
 nfsdcld
From:   Simo Sorce <simo@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Scott Mayhew <smayhew@redhat.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Fri, 30 Aug 2019 15:00:54 -0400
In-Reply-To: <A732539C-837A-4764-8281-C26E4203DE25@oracle.com>
References: <20190830162631.13195-1-smayhew@redhat.com>
         <A732539C-837A-4764-8281-C26E4203DE25@oracle.com>
Organization: Red Hat, Inc.
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 30 Aug 2019 19:00:57 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2019-08-30 at 12:32 -0400, Chuck Lever wrote:
> Simo, any comments or questions?

Although it is unlikely, in most scenarios to have a principal name
longer than 1024 characters, it is definitely not impossible, given the
principal name for hosts is generally compose of 3 components:
- a short service name
- a fully qualified hostname
- a realm name

The service name is generally "nfs" or "host" in the NFSv4 case,
however the realm name can be arbitrarily large and usually is the
capitalized domain name where the realm resides.

While thinking about this I wondered, why not simply hash (SHA-256 for
example) the principal name and store the hash instead?

It will make the length fixed and uniform and probably often shorter
than the real principal names, so saving space in the general case.

I am not against truncating to 1024, but a hash would be more elegant
and correct.

Simo.


> Patches can be found here:
> 
> https://marc.info/?l=linux-nfs&m=156718239314526&w=2
> 
> https://marc.info/?l=linux-nfs&m=156718239414527&w=2
> 
> 
> > On Aug 30, 2019, at 12:26 PM, Scott Mayhew <smayhew@redhat.com> wrote:
> > 
> > At the spring bakeathon, Chuck suggested that we should store the
> > kerberos principal in addition to the client id string in nfsdcld.  The
> > idea is to prevent an illegitimate client from reclaiming another
> > client's opens by supplying that client's id string.
> > 
> > The first patch lays some groundwork for supporting multiple message
> > versions for the nfsdcld upcalls, adding fields for version and message
> > length to the nfsd4_client_tracking_ops (these fields are only used for
> > the nfsdcld upcalls and ignored for the other tracking methods), as well
> > as an upcall to get the maximum version supported by the userspace
> > daemon.
> > 
> > The second patch actually adds the v2 message, which adds the principal
> > (actually just the first 1024 bytes) to the Cld_Create upcall and to the
> > Cld_GraceStart downcall (which is what loads the data in the
> > reclaim_str_hashtbl). I couldn't really figure out what the maximum length
> > of a kerberos principal actually is (looking at krb5.h the length field in
> > the struct krb5_data is an unsigned int, so I guess it can be pretty big).
> > I don't think the principal will be that large in practice, and even if
> > it is the first 1024 bytes should be sufficient for our purposes.
> > 
> > Scott Mayhew (2):
> >  nfsd: add a "GetVersion" upcall for nfsdcld
> >  nfsd: add support for upcall version 2
> > 
> > fs/nfsd/nfs4recover.c         | 332 +++++++++++++++++++++++++++-------
> > fs/nfsd/nfs4state.c           |   6 +-
> > fs/nfsd/state.h               |   3 +-
> > include/uapi/linux/nfsd/cld.h |  37 +++-
> > 4 files changed, 311 insertions(+), 67 deletions(-)
> > 
> > -- 
> > 2.17.2
> > 
> 
> --
> Chuck Lever
> 
> 
> 

-- 
Simo Sorce
RHEL Crypto Team
Red Hat, Inc




