Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39281B1B3F
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2020 03:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgDUBaH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Apr 2020 21:30:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57952 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725958AbgDUBaG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Apr 2020 21:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587432604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hXaCcY8JZK3t52m1dpaNXUh7xlv428jRqCXgWAIcjhA=;
        b=VIOdUl9R8lZpJBZtNniHG6Xh3ZBqxxj6zP10TdNEFkkQ+Exbe+cC90hrHnFVIDDVDcz2Tz
        jKTNk7bWDU1HE6viyCe8nlIiMmr8eER4S7l8PsDQVGbHlR8meMCEmeiRUZxD+sVPO00H2D
        YSnHDBVDIbaxDs2CnZG2vcJRXvXNqzw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-CgCJI-v7M6KksajxzHWp-Q-1; Mon, 20 Apr 2020 21:30:02 -0400
X-MC-Unique: CgCJI-v7M6KksajxzHWp-Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CCFA1005510;
        Tue, 21 Apr 2020 01:30:01 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B6D8BEA65;
        Tue, 21 Apr 2020 01:30:00 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 04B2F18095FF;
        Tue, 21 Apr 2020 01:30:00 +0000 (UTC)
Date:   Mon, 20 Apr 2020 21:29:59 -0400 (EDT)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     Jeff Layton <jlayton@redhat.com>
Cc:     David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@cjr.nz>,
        viro@zeniv.linux.org.uk, Steve French <smfrench@gmail.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, linux-afs@lists.infradead.org,
        ceph-devel@vger.kernel.org, keyrings@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, fweimer@redhat.com
Message-ID: <194431215.23515823.1587432599559.JavaMail.zimbra@redhat.com>
In-Reply-To: <93e1141d15e44a7490d756b0a00060660306fadc.camel@redhat.com>
References: <878siq587w.fsf@cjr.nz> <87imhvj7m6.fsf@cjr.nz> <CAH2r5mv5p=WJQu2SbTn53FeTsXyN6ke_CgEjVARQ3fX8QAtK_w@mail.gmail.com> <3865908.1586874010@warthog.procyon.org.uk> <927453.1587285472@warthog.procyon.org.uk> <1136024.1587388420@warthog.procyon.org.uk> <1986040.1587420879@warthog.procyon.org.uk> <93e1141d15e44a7490d756b0a00060660306fadc.camel@redhat.com>
Subject: Re: cifs - Race between IP address change and sget()?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.64.54.101, 10.4.195.9]
Thread-Topic: cifs - Race between IP address change and sget()?
Thread-Index: h/QZ5ARVf/JeS6sJ73LgvlwKgiRXoA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org





----- Original Message -----
> From: "Jeff Layton" <jlayton@redhat.com>
> To: "David Howells" <dhowells@redhat.com>, "Paulo Alcantara" <pc@cjr.nz>
> Cc: viro@zeniv.linux.org.uk, "Steve French" <smfrench@gmail.com>, "linux-nfs" <linux-nfs@vger.kernel.org>, "CIFS"
> <linux-cifs@vger.kernel.org>, linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, keyrings@vger.kernel.org,
> "Network Development" <netdev@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>, fweimer@redhat.com
> Sent: Tuesday, 21 April, 2020 8:30:37 AM
> Subject: Re: cifs - Race between IP address change and sget()?
> 
> On Mon, 2020-04-20 at 23:14 +0100, David Howells wrote:
> > Paulo Alcantara <pc@cjr.nz> wrote:
> > 
> > > > > > What happens if the IP address the superblock is going to changes,
> > > > > > then
> > > > > > another mount is made back to the original IP address?  Does the
> > > > > > second
> > > > > > mount just pick the original superblock?
> > > > > 
> > > > > It is going to transparently reconnect to the new ip address, SMB
> > > > > share,
> > > > > and cifs superblock is kept unchanged.  We, however, update internal
> > > > > TCP_Server_Info structure to reflect new destination ip address.
> > > > > 
> > > > > For the second mount, since the hostname (extracted out of the UNC
> > > > > path
> > > > > at mount time) resolves to a new ip address and that address was
> > > > > saved
> > > > > earlier in TCP_Server_Info structure during reconnect, we will end up
> > > > > reusing same cifs superblock as per
> > > > > fs/cifs/connect.c:cifs_match_super().
> > > > 
> > > > Would that be a bug?
> > > 
> > > Probably.
> > > 
> > > I'm not sure how that code is supposed to work, TBH.
> > 
> > Hmmm...  I think there may be a race here then - but I'm not sure it can be
> > avoided or if it matters.
> > 
> > Since the address is part of the primary key to sget() for cifs, changing
> > the
> > IP address will change the primary key.  Jeff tells me that this is
> > governed
> > by a spinlock taken by cifs_match_super().  However, sget() may be busy
> > attaching a new mount to the old superblock under the sb_lock core vfs
> > lock,
> > having already found a match.
> > 
> 
> Not exactly. Both places that match TCP_Server_Info objects by address
> hold the cifs_tcp_ses_lock. The address looks like it gets changed in
> reconn_set_ipaddr, and the lock is not currently taken there, AFAICT. I
> think it probably should be (at least around the cifs_convert_address
> call).

I think you are right. We need the spinlock around this call too.
I will send a patch to the list to add this.

> 
> > Should the change of parameters made by cifs be effected with sb_lock held
> > to
> > try and avoid ending up using the wrong superblock?
> > 
> > However, because the TCP_Server_Info is apparently updated, it looks like
> > my
> > original concern is not actually a problem (the idea that if a mounted
> > server
> > changes its IP address and then a new server comes online at the old IP
> > address, it might end up sharing superblocks because the IP address is part
> > of
> > the key).
> > 
> 
> I'm not sure we should concern ourselves with much more than just not
> allowing addresses to change while matching/searching. If you're
> standing up new servers at old addresses while you still have clients
> are migrating, then you are probably Doing it Wrong.

Agree. That is a migration process issue and not something we can/should
try to address in cifs.ko.



> 
> --
> Jeff Layton <jlayton@redhat.com>
> 
> 

