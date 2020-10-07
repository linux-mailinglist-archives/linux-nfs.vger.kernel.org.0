Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027F828653E
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Oct 2020 18:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgJGQu1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Oct 2020 12:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgJGQu1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Oct 2020 12:50:27 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCF6C061755
        for <linux-nfs@vger.kernel.org>; Wed,  7 Oct 2020 09:50:26 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id s47so2474966qth.4
        for <linux-nfs@vger.kernel.org>; Wed, 07 Oct 2020 09:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:subject:to:cc:in-reply-to:references:organization
         :mime-version:date:user-agent:content-transfer-encoding;
        bh=v5fkWWavFoMpc89w5iQzYCJZDfdv93KOFJLVoB5lsfQ=;
        b=YOxHwf1q8BXWeIR9na20uVsU8BuayVoSyhqor2B7nBeNOL3IKr64cYa9mkRQ2zJxMg
         a06Q8g1uQRQ5SsTo3jn1A+72qieAs0D8bipItWPdjaQFxDhSdFlrWcR05QjNIySL+a7N
         Rtgr3qak9pKl+dSo310WrBBNmWx2SJw5b7vLAAjw671KAPRFvFPJACJVy3ivQLhs5Xt0
         l+b5zX/ahG+SjtcgAmwbhEwEWjHLCx4cV2XYMkhR7xIL7DyyUXfJWrnEYk+pMHf/sfKt
         BbpLL+xGzK9txtywImbuip2yArifgy8dDycYIkvGXIqxF9yRPVl8uLZ3e9f9KTV2JCJZ
         Xbwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:subject:to:cc:in-reply-to
         :references:organization:mime-version:date:user-agent
         :content-transfer-encoding;
        bh=v5fkWWavFoMpc89w5iQzYCJZDfdv93KOFJLVoB5lsfQ=;
        b=EkoFbZcPOKkaHJPjpdW1XW0Yx6P1RWvFnhS1bQJYCqNFZxZCrff4hcgISF3/CkABhZ
         0hzpCkc9n/iVK39dzDImk1JoegjC97lGNkDxg85d2YlrlDjPiy5CMEnYO887iLYspwNW
         CoPmQN/hHuT2rb08bg/AKnVf/9Nxp2j8wCfV7NuRnzwlKOozGJBXlNuHZ/7a57b1+C/h
         XSVcPTL0jQ9tM19LdX+hRQh3/5yHNKRemrMRxPenFeW/eWbB+kBfGqhJJq1Ww+piUZVG
         s3sl3tFwBrDGdAyALpq4oQu3zOzXdRP9kSeDKlw+CZ4y0skX7m7TbIAImCSlZzyMvNuR
         TzWQ==
X-Gm-Message-State: AOAM533pBwTo3fZezLGjEQgLiQA0RYLrJS5bAvf8x2YnFrThVFI2PbYN
        Tmb4Wt9N/lYZ4iMzXwdmMA==
X-Google-Smtp-Source: ABdhPJwMD+WSG/qR7aPmSwOoS9xi5fi46O7aTe2Q6YiSnNjLh0GXCgAu6RCSz1RCWr3ovZ1goasYKw==
X-Received: by 2002:aed:25fc:: with SMTP id y57mr4032472qtc.199.1602089425743;
        Wed, 07 Oct 2020 09:50:25 -0700 (PDT)
Received: from leira (c-68-36-133-222.hsd1.mi.comcast.net. [68.36.133.222])
        by smtp.gmail.com with ESMTPSA id d21sm1860873qtp.97.2020.10.07.09.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 09:50:24 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trondmy@hammerspace.com>
Message-ID: <6d9aee613e9fb25509c9317910189ee37a2e4b43.camel@hammerspace.com>
Subject: Re: unsharing tcp connections from different NFS mounts
To:     Bruce Fields <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Benjamin Coddington <bcodding@redhat.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
In-Reply-To: <20201007160556.GE23452@fieldses.org>
References: <20201006151335.GB28306@fieldses.org>
         <95542179-0C20-4A1F-A835-77E73AD70DB8@redhat.com>
         <CAN-5tyGDC0VQqjqUNzs_Ka+-G_1eCScVxuXvWsp7xe7QYj69Ww@mail.gmail.com>
         <20201007001814.GA5138@fieldses.org>
         <57E3293C-5C49-4A80-957B-E490E6A9B32E@redhat.com>
         <5B5CF80C-494A-42D3-8D3F-51C0277D9E1B@redhat.com>
         <8ED5511E-25DE-4C06-9E26-A1947383C86A@oracle.com>
         <20201007140502.GC23452@fieldses.org>
         <85F496CD-9AAC-451C-A224-FCD138BDC591@oracle.com>
         <20201007160556.GE23452@fieldses.org>
Organization: Hammerspace Inc
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Wed, 07 Oct 2020 12:44:42 -0400
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2020-10-07 at 12:05 -0400, Bruce Fields wrote:
> On Wed, Oct 07, 2020 at 10:15:39AM -0400, Chuck Lever wrote:
> > 
> > > On Oct 7, 2020, at 10:05 AM, Bruce Fields <bfields@fieldses.org>
> > > wrote:
> > > 
> > > On Wed, Oct 07, 2020 at 09:45:50AM -0400, Chuck Lever wrote:
> > > > 
> > > > > On Oct 7, 2020, at 8:55 AM, Benjamin Coddington <
> > > > > bcodding@redhat.com> wrote:
> > > > > 
> > > > > On 7 Oct 2020, at 7:27, Benjamin Coddington wrote:
> > > > > 
> > > > > > On 6 Oct 2020, at 20:18, J. Bruce Fields wrote:
> > > > > > 
> > > > > > > On Tue, Oct 06, 2020 at 05:46:11PM -0400, Olga
> > > > > > > Kornievskaia wrote:
> > > > > > > > On Tue, Oct 6, 2020 at 3:38 PM Benjamin Coddington <
> > > > > > > > bcodding@redhat.com> wrote:
> > > > > > > > > On 6 Oct 2020, at 11:13, J. Bruce Fields wrote:
> > > > > > > Looks like nfs4_init_{non}uniform_client_string() stores
> > > > > > > it in
> > > > > > > cl_owner_id, and I was thinking that meant cl_owner_id
> > > > > > > would be used
> > > > > > > from then on....
> > > > > > > 
> > > > > > > But actually, I think it may run that again on recovery,
> > > > > > > yes, so I bet
> > > > > > > changing the nfs4_unique_id parameter midway like this
> > > > > > > could cause bugs
> > > > > > > on recovery.
> > > > > > 
> > > > > > Ah, that's what I thought as well.  Thanks for looking
> > > > > > closer Olga!
> > > > > 
> > > > > Well, no -- it does indeed continue to use the original
> > > > > cl_owner_id.  We
> > > > > only jump through nfs4_init_uniquifier_client_string() if
> > > > > cl_owner_id is
> > > > > NULL:
> > > > > 
> > > > > 6087 static int
> > > > > 6088 nfs4_init_uniform_client_string(struct nfs_client *clp)
> > > > > 6089 {
> > > > > 6090     size_t len;
> > > > > 6091     char *str;
> > > > > 6092
> > > > > 6093     if (clp->cl_owner_id != NULL)
> > > > > 6094         return 0;
> > > > > 6095
> > > > > 6096     if (nfs4_client_id_uniquifier[0] != '\0')
> > > > > 6097         return nfs4_init_uniquifier_client_string(clp);
> > > > > 6098
> > > > > 
> > > > > 
> > > > > Testing proves this out as well for both EXCHANGE_ID and
> > > > > SETCLIENTID.
> > > > > 
> > > > > Is there any precedent for stabilizing module parameters as
> > > > > part of a
> > > > > supported interface?  Maybe this ought to be a mount option,
> > > > > so client can
> > > > > set a uniquifier per-mount.
> > > > 
> > > > The protocol is designed as one client-ID per client. FreeBSD
> > > > is
> > > > the only client I know of that uses one client-ID per mount,
> > > > fwiw.
> > > > 
> > > > You are suggesting each mount point would have its own lease.
> > > > There
> > > > would likely be deeper implementation changes needed than just
> > > > specifying a unique client-ID for each mount point.
> > > 
> > > Huh, I thought that should do it.
> > > 
> > > Do you have something specific in mind?
> > 
> > The relationship between nfs_client and nfs_server structs comes to
> > mind.
> 
> I'm not following.  Do you have a specific problem in mind?
> 

The problem that all locks etc are tied to the lease, so if you change
the clientid (and hence change the lease) then you need to ensure that
the client knows to which lease the locks belong, that it is able to
respond appropriately to all delegation recalls, layout recalls, ...
etc.
This need to track things on a per-lease basis is why we have the
struct nfs_client. Things that are tracked on a per-superblock basis
are tracked by the struct nfs_server.

However all this is moot as long as nobody can explain why we'd want to
do all this.

As far as I can tell, this thread started with a complaint that
performance suffers when we don't allow setups that hack the client by
pretending that a multi-homed server is actually multiple different
servers.

AFAICS Tom Talpey's question is the relevant one. Why is there a
performance regression being seen by these setups when they share the
same connection? Is it really the connection, or is it the fact that
they all share the same fixed-slot session?

I did see Igor's claim that there is a QoS issue (which afaics would
also affect NFSv3), but why do I care about QoS as a per-mountpoint
feature?

-- 
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com



