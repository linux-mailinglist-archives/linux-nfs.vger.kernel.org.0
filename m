Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8324C1B8
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2019 21:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfFSTur (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jun 2019 15:50:47 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41331 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfFSTur (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Jun 2019 15:50:47 -0400
Received: by mail-qt1-f196.google.com with SMTP id d17so483307qtj.8
        for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2019 12:50:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9UqMkwWmLaKxEjBWC9VrXMYNUxYkyv4UzRjUoOCsCvE=;
        b=p/eTHsjc5eh1nJfvtq7+3k8Ns39R2PvzpKt/WL7ChyV5v7IRkfWKTQt1qOpbhk7Wvd
         7l52KyNtFDARMW4u1rSwKlZilNPqUA+ZuzDBTbz7iY6LqZZY6/GqSFD2syPXBRVc6EZO
         iCl6hBja0iI3xtUC+8Ft0404NNzTXYPGJHv6sk5Nqy/KRauIDQnhUbcaOEd1AnEOpDZG
         +AKMe7rGaE1pLczVDhZCT4TmfbPeum1j4gxZJj8W3aSBSF1Ulic5/2Cqca5ot6wE1D0g
         qH7lrEEszUSP2tJvCQz6TwnKbekHe4kwIyGx1wquadFjgwGaL3maovyihrFwzQjkf8GE
         gC4Q==
X-Gm-Message-State: APjAAAUk8Zy7EttYVwXg5Dl89fYBXQB/daxlzJ4E7xw29o1VMHn+zqxW
        jeVxCgaYPqIhQUGAcAxMP+lS1yl+evY=
X-Google-Smtp-Source: APXvYqzDW1p3jw3/JQPgdZR0eXrx5OWKi197hnq5gBudBxHbvuGmFN995nr+sBv5Wa5hWnMjmb3F3g==
X-Received: by 2002:a0c:b012:: with SMTP id k18mr35631188qvc.74.1560973845687;
        Wed, 19 Jun 2019 12:50:45 -0700 (PDT)
Received: from dhcp-12-212-173.gsslab.rdu.redhat.com (nat-pool-rdu-t.redhat.com. [66.187.233.202])
        by smtp.gmail.com with ESMTPSA id l5sm1001433qte.9.2019.06.19.12.50.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 12:50:45 -0700 (PDT)
Message-ID: <f2ac002cabdf21b61644a53969eaf0e1546384b0.camel@redhat.com>
Subject: Re: [PATCH 3/3] mountstats: Check for RPC iostats version >= 1.1
 with error counts
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Steve Dickson <SteveD@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Wed, 19 Jun 2019 15:50:44 -0400
In-Reply-To: <DB163079-2AE4-4C1E-A317-27E1F9745788@oracle.com>
References: <20190612190229.31811-1-dwysocha@redhat.com>
         <20190613120314.1864-1-dwysocha@redhat.com>
         <20190613120314.1864-3-dwysocha@redhat.com>
         <FD291454-53BB-46DB-BEBE-9AA2F8DE18DE@oracle.com>
         <CALF+zOkFKXZQsFodJphAg1UBNxKyQq_GfO1wFqfak0TTre=dng@mail.gmail.com>
         <7211D5DF-6923-459D-9B84-2BD264EB9F11@oracle.com>
         <E3BDBBD8-C75C-48EA-85D5-37657DF3AE14@oracle.com>
         <449f121418f5667436e6d42432c6404aa0fed9e9.camel@redhat.com>
         <DB163079-2AE4-4C1E-A317-27E1F9745788@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2019-06-19 at 15:46 -0400, Chuck Lever wrote:
> > On Jun 19, 2019, at 3:42 PM, Dave Wysochanski <dwysocha@redhat.com>
> > wrote:
> > 
> > On Wed, 2019-06-19 at 13:45 -0400, Chuck Lever wrote:
> > > > On Jun 19, 2019, at 1:42 PM, Chuck Lever <
> > > > chuck.lever@oracle.com>
> > > > wrote:
> > > > 
> > > > 
> > > > 
> > > > > On Jun 19, 2019, at 1:22 PM, David Wysochanski <
> > > > > dwysocha@redhat.com> wrote:
> > > > > 
> > > > > 
> > > > > 
> > > > > On Wed, Jun 19, 2019 at 12:35 PM Chuck Lever <
> > > > > chuck.lever@oracle.com> wrote:
> > > > > 
> > > > > 
> > > > > > On Jun 13, 2019, at 8:03 AM, Dave Wysochanski <
> > > > > > dwysocha@redhat.com> wrote:
> > > > > > 
> > > > > > Add explicit check for statsvers instead of array based
> > > > > > check.
> > > > > 
> > > > > Hi Dave,
> > > > > 
> > > > > I don't understand why this change is necessary. The patch
> > > > > description
> > > > > should explain.
> > > > > 
> > > > > 
> > > > > Steve had already taken commit 73491ef for mountstats which
> > > > > was
> > > > > an array based check.  This just makes this patch consistent
> > > > > with
> > > > > the others.  Is that what you mean - you want a statement
> > > > > about
> > > > > consistency and refer to the other commit?  How about:
> > > > > 
> > > > > Commit 73491ef added per-op error counts for mountstats
> > > > > command
> > > > > but used an array based check rather than checking statsver.
> > > > > Add
> > > > > explicit check for statsver instead of array based check for
> > > > > consistency with other tools.
> > > > 
> > > > This is a better patch description (explains "why" not "what"),
> > > > but I'm not clear why this change is necessary in either place.
> > > 
> > > In other words, was this change necessary to fix a bug? Or is
> > > this a defensive change to make parsing more robust?
> > > 
> > 
> > I try to state "fix" somewhere in there when it is a bug fix - so
> > no
> > this does not fix a bug.  In in some ways the original check was
> > better
> > because it makes no assumption of what 'statsver' means at any
> > time. 
> > I'm not sure if you're really concerned about the commit message or
> > you
> > would prefer the array check?
> 
> Both. The array check is done for all the other variables too, IIRC.
> There doesn't seem to be a reason to check the statvers. If it's not
> too much trouble, please resubmit so that the new checks are
> consistent
> with existing checks.
> 

No problem at all - will do!


> 
> > I can see argument for array check and I
> > can change the other patches and resubmit if you prefer that.
> > 
> > Commit 73491ef added per-op error counts for mountstats command
> > but used an array based check rather than checking statsver.  Check
> > statsver >= 1.1 explicitly as this documents when this new count
> > was
> > added to the kernel.
> 
> Not sure there's a need for the statvers bump here either. There
> are some rules about when a statvers bump is necessary, but in my
> old age I don't remember what they are. Anyway, if the statvers is
> bumped already, no big deal.
> 

As far as I understood this version covers the rpc_iostats structure so
yes I thought it was necessary so I changed it when I added
"om_error_status"
http://git.linux-nfs.org/?p=trondmy/linux-nfs.git;a=patch;h=6e034f84c67d677e87e11e42d1faaca854023d16


> 
> > > > > > Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> > > > > > ---
> > > > > > tools/mountstats/mountstats.py | 2 +-
> > > > > > 1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/tools/mountstats/mountstats.py
> > > > > > b/tools/mountstats/mountstats.py
> > > > > > index 5f13bf8e..2ebbf945 100755
> > > > > > --- a/tools/mountstats/mountstats.py
> > > > > > +++ b/tools/mountstats/mountstats.py
> > > > > > @@ -476,7 +476,7 @@ class DeviceData:
> > > > > >               if retrans != 0:
> > > > > >                   print('\t%d retrans (%d%%)' % (retrans,
> > > > > > ((retrans * 100) / count)), end=' ')
> > > > > >                   print('\t%d major timeouts' % stats[3],
> > > > > > end='')
> > > > > > -                if len(stats) >= 10 and stats[9] != 0:
> > > > > > +                if self.__rpc_data['statsvers'] >= 1.1 and
> > > > > > stats[9] != 0:
> > > > > >                   print('\t%d errors (%d%%)' % (stats[9],
> > > > > > ((stats[9] * 100) / count)))
> > > > > >               else:
> > > > > >                   print('')
> > > > > > -- 
> > > > > > 2.20.1
> > > > > > 
> > > > > 
> > > > > --
> > > > > Chuck Lever
> > > > > 
> > > > > 
> > > > > 
> > > > > 
> > > > > 
> > > > > -- 
> > > > > Dave Wysochanski
> > > > > Principal Software Maintenance Engineer
> > > > > T: 919-754-4024  
> > > > 
> > > > --
> > > > Chuck Lever
> > > 
> > > --
> > > Chuck Lever
> 
> --
> Chuck Lever
> 
> 
> 


