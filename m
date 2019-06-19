Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0C7F4C19E
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2019 21:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfFSTmM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jun 2019 15:42:12 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39188 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfFSTmM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Jun 2019 15:42:12 -0400
Received: by mail-qk1-f195.google.com with SMTP id i125so326994qkd.6
        for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2019 12:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BIrcII/PthTgVpYZ9qYFTZPuvXwQTQFAuZS689CpjVo=;
        b=mkvUtPbejGqArcbhEvDKwq8trp1+DoKmLFom2jSCKVKoGKCKQJzi6zothgW7+YLNE2
         SYzuIa2Y2ceRHsh7B/dCb7svv1kfGEHy6CfQ6lKOntSt8AvPH4jn7jDkgVOQSXR2dRb2
         dl/FMKA+GQ6hPPjQNh6rzNrqe2zAHF3SyX0x7GF/MhMA16g6+EWiDMnijAPYehPC9dte
         nM0yOsd495L1e+mVWsKChZW2ygahtK5uxFBd6C5AOp642J6BLW9dcsPIstNyRQDqm2nc
         w1FSzqHRHyowGc9S3NSoRAYdplLcBiiK75KKpYDvaSS86VNv5KExzomouvKlcFjQSImO
         49hw==
X-Gm-Message-State: APjAAAUU4NJz/xNaZ3vppcyzMmAFLfsl/dDUxu7+Ckcahs6/CgFX9mfu
        cSQS+4ynv5l3nkcmyujcDV4z7w==
X-Google-Smtp-Source: APXvYqx8/pr8HKav0LjrqgQbNJokOamZBPTnMOJhMJrvMOnNhxBKb1MLciYARlfqtnkQUAeq9x79Hg==
X-Received: by 2002:a37:4243:: with SMTP id p64mr19071384qka.9.1560973331505;
        Wed, 19 Jun 2019 12:42:11 -0700 (PDT)
Received: from dhcp-12-212-173.gsslab.rdu.redhat.com (nat-pool-rdu-t.redhat.com. [66.187.233.202])
        by smtp.gmail.com with ESMTPSA id e4sm11562670qtc.3.2019.06.19.12.42.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 12:42:11 -0700 (PDT)
Message-ID: <449f121418f5667436e6d42432c6404aa0fed9e9.camel@redhat.com>
Subject: Re: [PATCH 3/3] mountstats: Check for RPC iostats version >= 1.1
 with error counts
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Steve Dickson <SteveD@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Wed, 19 Jun 2019 15:42:10 -0400
In-Reply-To: <E3BDBBD8-C75C-48EA-85D5-37657DF3AE14@oracle.com>
References: <20190612190229.31811-1-dwysocha@redhat.com>
         <20190613120314.1864-1-dwysocha@redhat.com>
         <20190613120314.1864-3-dwysocha@redhat.com>
         <FD291454-53BB-46DB-BEBE-9AA2F8DE18DE@oracle.com>
         <CALF+zOkFKXZQsFodJphAg1UBNxKyQq_GfO1wFqfak0TTre=dng@mail.gmail.com>
         <7211D5DF-6923-459D-9B84-2BD264EB9F11@oracle.com>
         <E3BDBBD8-C75C-48EA-85D5-37657DF3AE14@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2019-06-19 at 13:45 -0400, Chuck Lever wrote:
> > On Jun 19, 2019, at 1:42 PM, Chuck Lever <chuck.lever@oracle.com>
> > wrote:
> > 
> > 
> > 
> > > On Jun 19, 2019, at 1:22 PM, David Wysochanski <
> > > dwysocha@redhat.com> wrote:
> > > 
> > > 
> > > 
> > > On Wed, Jun 19, 2019 at 12:35 PM Chuck Lever <
> > > chuck.lever@oracle.com> wrote:
> > > 
> > > 
> > > > On Jun 13, 2019, at 8:03 AM, Dave Wysochanski <
> > > > dwysocha@redhat.com> wrote:
> > > > 
> > > > Add explicit check for statsvers instead of array based check.
> > > 
> > > Hi Dave,
> > > 
> > > I don't understand why this change is necessary. The patch
> > > description
> > > should explain.
> > > 
> > > 
> > > Steve had already taken commit 73491ef for mountstats which was
> > > an array based check.  This just makes this patch consistent with
> > > the others.  Is that what you mean - you want a statement about
> > > consistency and refer to the other commit?  How about:
> > > 
> > > Commit 73491ef added per-op error counts for mountstats command
> > > but used an array based check rather than checking statsver. Add
> > > explicit check for statsver instead of array based check for
> > > consistency with other tools.
> > 
> > This is a better patch description (explains "why" not "what"),
> > but I'm not clear why this change is necessary in either place.
> 
> In other words, was this change necessary to fix a bug? Or is
> this a defensive change to make parsing more robust?
> 

I try to state "fix" somewhere in there when it is a bug fix - so no
this does not fix a bug.  In in some ways the original check was better
because it makes no assumption of what 'statsver' means at any time. 
I'm not sure if you're really concerned about the commit message or you
would prefer the array check?  I can see argument for array check and I
can change the other patches and resubmit if you prefer that.

Commit 73491ef added per-op error counts for mountstats command
but used an array based check rather than checking statsver.  Check
statsver >= 1.1 explicitly as this documents when this new count was
added to the kernel.


> 
> > > > Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> > > > ---
> > > > tools/mountstats/mountstats.py | 2 +-
> > > > 1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/tools/mountstats/mountstats.py
> > > > b/tools/mountstats/mountstats.py
> > > > index 5f13bf8e..2ebbf945 100755
> > > > --- a/tools/mountstats/mountstats.py
> > > > +++ b/tools/mountstats/mountstats.py
> > > > @@ -476,7 +476,7 @@ class DeviceData:
> > > >                if retrans != 0:
> > > >                    print('\t%d retrans (%d%%)' % (retrans,
> > > > ((retrans * 100) / count)), end=' ')
> > > >                    print('\t%d major timeouts' % stats[3],
> > > > end='')
> > > > -                if len(stats) >= 10 and stats[9] != 0:
> > > > +                if self.__rpc_data['statsvers'] >= 1.1 and
> > > > stats[9] != 0:
> > > >                    print('\t%d errors (%d%%)' % (stats[9],
> > > > ((stats[9] * 100) / count)))
> > > >                else:
> > > >                    print('')
> > > > -- 
> > > > 2.20.1
> > > > 
> > > 
> > > --
> > > Chuck Lever
> > > 
> > > 
> > > 
> > > 
> > > 
> > > -- 
> > > Dave Wysochanski
> > > Principal Software Maintenance Engineer
> > > T: 919-754-4024  
> > 
> > --
> > Chuck Lever
> 
> --
> Chuck Lever
> 
> 
> 


