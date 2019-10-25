Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7D1BE4FFA
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Oct 2019 17:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440610AbfJYPUx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Oct 2019 11:20:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51829 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2440561AbfJYPUx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Oct 2019 11:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572016851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bXBncjgboz5u7Y9MyqruxUXQZXD7Adz3b/33SNwrgwA=;
        b=cGdmQFCfYBe2omHVxHtQP7FWlr0GydgqqP1cOTjwwGiPao5zZ4OrfSn1xi69Qxb9u+qjCV
        l5iTHOnemhAltXHSzHB8VVFEbsb1Ro3fA7oLD0Z/oHHy/6LsnM8UEgPk0/WLZVSHvc+UCP
        X+HBolE9NUa313wwtMfRwCMeJIKeFzA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-HqYytm6pNBiCXWZfZJgp1Q-1; Fri, 25 Oct 2019 11:20:50 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 495CB8017D9;
        Fri, 25 Oct 2019 15:20:49 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-126-116.rdu2.redhat.com [10.10.126.116])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1140D60BEC;
        Fri, 25 Oct 2019 15:20:49 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id A9875120039; Fri, 25 Oct 2019 11:20:47 -0400 (EDT)
Date:   Fri, 25 Oct 2019 11:20:47 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     NeilBrown <neilb@suse.de>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: uncollected nfsd open owners
Message-ID: <20191025152047.GB16053@pick.fieldses.org>
References: <87mudpfwkj.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
In-Reply-To: <87mudpfwkj.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: HqYytm6pNBiCXWZfZJgp1Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Oct 25, 2019 at 12:22:36PM +1100, NeilBrown wrote:
>  I have a coredump from a machine that was running as an NFS server.
>  nfs4_laundromat was trying to expire a client, and in particular was
>  cleaning up the ->cl_openowners.
>  As there were 6.5 million of these, it took rather longer than the
>  softlockup timer thought was acceptable, and hence the core dump.
>=20
>  Those open owners that I looked at had empty so_stateids lists, so I
>  would normally expect them to be on the close_lru and to be removed
>  fairly soon.  But they weren't (only 32 openowners on close_lru).
>=20
>  The only explanation I can think of for this is that maybe an OPEN
>  request successfully got through nfs4_process_open1(), thus creating an
>  open owner, but failed to get to or through nfs4_process_open2(), and
>  so didn't add a stateid.  I *think* this can leave an openowner that is
>  unused but will never be cleaned up (until the client is expired, which
>  might be too late).
>=20
>  Is this possible?  If so, how should we handle those openowners which
>  never had a stateid?
>  In 3.0 (which it the kernel were I saw this) I could probably just put
>  the openowner on the close_lru when it is created.
>  In more recent kernels, it seems to be assumed that openowners are only
>  on close_lru if they have a oo_last_closed_stid.  Would we need a
>  separate "never used lru", or should they just be destroyed as soon as
>  the open fails?

Hopefully we can just throw the new openowner away when the open fails.

But it looks like the new openowner is visible on global data structures
by then, so we need to be sure somebody else isn't about to use it.

>  Also, should we put a cond_resched() in some or all of those loops in
>  __destroy_client() ??

Looks like it helped find a bug in this case....

Destroying a client that has a ton of active state should be an unusual
situation.

I don't know, maybe?  I'm sure this isn't the only spinlock-protected
kernel code where we don't have a strict bound on a loop, what's been
the practice elsewhere?  Worst case, the realtime code allows preempting
spinlocks, right?

Might be nice to have some sort of limits on the number of objects (like
stateowners) that can be created.  But it's a pain when we get one of
those limits wrong. (See
git log -L :nfsd4_get_drc_mem:fs/nfsd/nfs4state.c.)

--b.

