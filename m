Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890AB2CCB67
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Dec 2020 02:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgLCBHR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Dec 2020 20:07:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33071 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726410AbgLCBHR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Dec 2020 20:07:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606957550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dLnRpQt2/4dYCjKr82ESG1mUkPFg3TzB3jEu0MimuwM=;
        b=DZAZ/l24Tvp/Y4ZyhExX3u6NSY8/y72Jj4OUwnpb8npLQYBTBn8wW9AuWKW3h1+CPacqn2
        K62n9lPGd4Dqnwn6Z5ezqLZ5UyCi7hh32jjJ299wdpWH5YDzOLEtCykahroHzX402JhpOT
        A2QadodKsTSFTsA/CTRHZhMkxwOgvWo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-LGcMAFr6NbSfaYvQ7HTxog-1; Wed, 02 Dec 2020 20:05:49 -0500
X-MC-Unique: LGcMAFr6NbSfaYvQ7HTxog-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B94281007465;
        Thu,  3 Dec 2020 01:05:47 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-113-223.rdu2.redhat.com [10.10.113.223])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 620FF60854;
        Thu,  3 Dec 2020 01:05:47 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 83CB412037D; Wed,  2 Dec 2020 20:05:46 -0500 (EST)
Date:   Wed, 2 Dec 2020 20:05:46 -0500
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "steved@redhat.com" <steved@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] mountd: always root squash on the pseudofs
Message-ID: <20201203010546.GB348347@pick.fieldses.org>
References: <1606949804-31417-1-git-send-email-bfields@fieldses.org>
 <1606949804-31417-2-git-send-email-bfields@fieldses.org>
 <c9f91aa0ac98cd132fb212166aba01864c609939.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c9f91aa0ac98cd132fb212166aba01864c609939.camel@hammerspace.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Dec 03, 2020 at 12:54:53AM +0000, Trond Myklebust wrote:
> On Wed, 2020-12-02 at 17:56 -0500, J. Bruce Fields wrote:
> > From: "J. Bruce Fields" <bfields@redhat.com>
> > 
> > As with security flavors and "secure" ports, we tried to code this so
> > that pseudofs directories would inherit root squashing from their
> > children, but it doesn't really work as coded and I'm not sure it's
> > useful.
> > 
> > Just root squash always.  If it turns out somebody's exporting
> > directories that are only readable by root, I guess we can try to do
> > something else here, but frankly that sounds like a pretty weird
> > configuration.
> > 
> > Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> > ---
> >  utils/mountd/v4root.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/utils/mountd/v4root.c b/utils/mountd/v4root.c
> > index 2ac4e87898c0..36543401f296 100644
> > --- a/utils/mountd/v4root.c
> > +++ b/utils/mountd/v4root.c
> > @@ -60,8 +60,6 @@ set_pseudofs_security(struct exportent *pseudo, int
> > flags)
> >         struct flav_info *flav;
> >         int i;
> >  
> > -       if ((flags & NFSEXP_ROOTSQUASH) == 0)
> > -               pseudo->e_flags &= ~NFSEXP_ROOTSQUASH;
> >         for (flav = flav_map; flav < flav_map + flav_map_size;
> > flav++) {
> >                 struct sec_entry *new;
> >  
> 
> Hmm... What is the harm in allowing root to be unsquashed here? Isn't
> this really all about respecting lookup permissions, or could a user
> actually modify something in the pseudofs? If the latter, then that
> sounds like a bug (the pseudofs should always be read-only).

Yeah, it should only be read-only.

> The consequence of not being able to look up a directory in the
> pseudofs is that the NFSv4 client will be completely unable to mount
> that subtree, so squashing root could make a major difference.

Fair enough, I'll resend.

--b.

