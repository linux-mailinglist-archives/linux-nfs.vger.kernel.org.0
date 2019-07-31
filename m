Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADA9D7D04A
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jul 2019 23:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbfGaVvU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Jul 2019 17:51:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58036 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727987AbfGaVvU (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 31 Jul 2019 17:51:20 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2D7EC8CB48;
        Wed, 31 Jul 2019 21:51:20 +0000 (UTC)
Received: from parsley.fieldses.org (ovpn-121-106.rdu2.redhat.com [10.10.121.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0689600D1;
        Wed, 31 Jul 2019 21:51:19 +0000 (UTC)
Received: by parsley.fieldses.org (Postfix, from userid 2815)
        id 8A4051804A0; Wed, 31 Jul 2019 17:51:18 -0400 (EDT)
Date:   Wed, 31 Jul 2019 17:51:18 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 5/8] NFSD check stateids against copy stateids
Message-ID: <20190731215118.GA13311@parsley.fieldses.org>
References: <20190708192352.12614-1-olga.kornievskaia@gmail.com>
 <20190708192352.12614-6-olga.kornievskaia@gmail.com>
 <20190719220116.GA24373@fieldses.org>
 <CAN-5tyHdxBcEH0xPV2814nUMEHPCsQ9iD_A7K=W3ZeE6b4OJxg@mail.gmail.com>
 <20190723205846.GB19559@fieldses.org>
 <CAN-5tyFTRr9KPYAzq-EaOMqDeJU31-qHGsLyCmEtd18OMxCFNQ@mail.gmail.com>
 <CAN-5tyEbwjPNbXKWXv+3=geisjH-i=xKWRqgyXa3v9Xk=OvdEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyEbwjPNbXKWXv+3=geisjH-i=xKWRqgyXa3v9Xk=OvdEw@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 31 Jul 2019 21:51:20 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jul 31, 2019 at 05:10:01PM -0400, Olga Kornievskaia wrote:
> I'm having difficulty with this patch because there is no good way to
> know when the copy_notify stateid can be freed. What I can propose is
> to have the linux client send a FREE_STATEID with the copy_notify
> stateid and use that as the trigger to free the state. In that case,
> I'll keep a reference on the parent until the FREE_STATEID is
> received.
> 
> This is not in the spec (though seems like a good idea to tell the
> source server it's ok to clean up) so other implementations might not
> choose this approach so we'll have problems with stateids sticking
> around.

https://tools.ietf.org/html/rfc7862#page-71

	"If the cnr_lease_time expires while the destination server is
	still reading the source file, the destination server is allowed
	to finish reading the file.  If the cnr_lease_time expires
	before the destination server uses READ or READ_PLUS to begin
	the transfer, the source server can use NFS4ERR_PARTNER_NO_AUTH
	to inform the destination server that the cnr_lease_time has
	expired."

The spec doesn't really define what "is allowed to finish reading the
file" means, but I think the source server should decide somehow whether
the target's done.  And "hasn't sent a read in cnr_lease_time" seems
like a pretty good conservative definition that would be easy to
enforce.  Worst case, if the network goes down for a couple minutes and
the target tries to pick up a copy where it left off, it'll get
PARTNER_NO_AUTH.  I assume that results in the same error being returned
the client, at which point the client knows that the copy_notify stateid
may have installed and can do what it chooses to recover (like send a
new copy_notify).

The FREE_STATEID might also be a good idea, but I guess we can't count
on it.

Maybe the spec could use some errata to clarify that FREE_STATEID is
allowed on copy_notify stateids, that clients should send it when
they're done, and that servers are allowed to expire copy_notify
stateid's even after their first use.

--b.
