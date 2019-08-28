Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17A9AA0493
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2019 16:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfH1OQO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Aug 2019 10:16:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60528 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbfH1OQN (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 28 Aug 2019 10:16:13 -0400
Received: from mail-yw1-f72.google.com (mail-yw1-f72.google.com [209.85.161.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E697412A2
        for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2019 14:16:12 +0000 (UTC)
Received: by mail-yw1-f72.google.com with SMTP id m19so1975223ywj.11
        for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2019 07:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=EV054D4+2wLlRVgRqmoYMktUluiYoYZ4zJ6m6SEvDlE=;
        b=KXX90/NroiVJnNLghyjSHNr0sW3VcaQ5d2mukI2N+z47mYTgpX5BwtfhzoBwc2oH2o
         ibbQxSK8igqXcZRVdLugaJ4LcCdyjmfcVyXhPiPGvX0qy88+oyEwcZFRCxPamR+c8Xlw
         E9W0O16WwSXVOSGYY3+0PBoqLtz5e6Y/pJ9q75T8r+v6VghjbL2b9Ngm7hhvJtK4iOfq
         GyZxn/lY7/AZba9ho9k2HGLJ+HpsTvrpzbtQYsQjlfl+ah9RF1AXtXplUgdrifJ0LL6A
         MvjtYG0MJ+O1vtMIG+CjkrOh8/QfZEqivzfUAZV+uthrCyqFOeAaSNLos+Vt5CHSTM0T
         O64g==
X-Gm-Message-State: APjAAAVGT/cHrCEfkDP0D37vYeJuQH0aIOYc3HsBPszxHYtz7EOJlxVK
        dThGCY3DAek8ptGIj9hIMbw2enWoIP9Mqm8Wh8wEouARhTJ5TjreqUIIx+gxy31oWnpsJhqnA92
        9nH1/du4sIDyfyMDs5cj8
X-Received: by 2002:a0d:cc54:: with SMTP id o81mr2983986ywd.447.1567001772342;
        Wed, 28 Aug 2019 07:16:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqylNaO2ULLUKGpe12GTH8Y5pWl3UGsHOahouZPuVqL8iwyTyRUimoaublz46+vjKKXTR52hYQ==
X-Received: by 2002:a0d:cc54:: with SMTP id o81mr2983959ywd.447.1567001771972;
        Wed, 28 Aug 2019 07:16:11 -0700 (PDT)
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id t186sm548661ywt.20.2019.08.28.07.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 07:16:11 -0700 (PDT)
Message-ID: <31658faabfbe3b4c2925bd899e264adf501fbc75.camel@redhat.com>
Subject: Re: [PATCH 0/3] Handling NFSv3 I/O errors in knfsd
From:   Jeff Layton <jlayton@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Bruce Fields <bfields@redhat.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Wed, 28 Aug 2019 10:16:09 -0400
In-Reply-To: <990B7B57-53B8-4ECB-A08B-1AFD2FCE13A6@oracle.com>
References: <20190826205156.GA27834@fieldses.org>
         <ef9f2791ef395d7c968a386ce0a32ea503d6478f.camel@hammerspace.com>
         <61F77AD6-BD02-4322-B944-0DC263EB9BD8@oracle.com>
         <ec7a06f8e74867e65c26580e8504e2879f4cd595.camel@hammerspace.com>
         <20190827145819.GB9804@fieldses.org> <20190827145912.GC9804@fieldses.org>
         <1ee75165d548b336f5724b6d655aa2545b9270c3.camel@hammerspace.com>
         <20190828134839.GA26492@fieldses.org>
         <ed2a86da204cbf644ef2dada4bda2b899da48764.camel@redhat.com>
         <45582F32-69C7-4DC8-A608-E45038A44D42@oracle.com>
         <20190828140044.GA14249@parsley.fieldses.org>
         <990B7B57-53B8-4ECB-A08B-1AFD2FCE13A6@oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2019-08-28 at 10:03 -0400, Chuck Lever wrote:
> > On Aug 28, 2019, at 10:00 AM, J. Bruce Fields <bfields@redhat.com> wrote:
> > 
> > On Wed, Aug 28, 2019 at 09:57:25AM -0400, Chuck Lever wrote:
> > > 
> > > > On Aug 28, 2019, at 9:51 AM, Jeff Layton <jlayton@redhat.com> wrote:
> > > > 
> > > > On Wed, 2019-08-28 at 09:48 -0400, bfields@fieldses.org wrote:
> > > > > On Tue, Aug 27, 2019 at 03:15:35PM +0000, Trond Myklebust wrote:
> > > > > > I'm open to other suggestions, but I'm having trouble finding one that
> > > > > > can scale correctly (i.e. not require per-client tracking), prevent
> > > > > > silent corruption (by causing clients to miss errors), while not
> > > > > > relying on optional features that may not be implemented by all NFSv3
> > > > > > clients (e.g. per-file write verifiers are not implemented by *BSD).
> > > > > > 
> > > > > > That said, it seems to me that to do nothing should not be an option,
> > > > > > as that would imply tolerating silent corruption of file data.
> > > > > 
> > > > > So should we increment the boot verifier every time we discover an error
> > > > > on an asynchronous write?
> > > > > 
> > > > 
> > > > I think so. Otherwise, only one client will ever see that error.
> > > 
> > > +1
> > > 
> > > I'm not familiar with the details of how the Linux NFS server
> > > implements the boot verifier: Will a verifier bump be effective
> > > for all file systems that server exports?
> > 
> > Yes.  It will be per network namespace, but that's the only limit.
> > 
> > > If so, is that an acceptable cost?
> > 
> > It means clients will resend all their uncommitted writes.  That could
> > certainly make write errors more expensive.  But maybe you've already
> > got bigger problems if you've got a full or failing disk?
> 
> One full filesystem will impact the behavior of all other exported
> filesystems. That might be surprising behavior to a server administrator.
> I don't have any suggestions other than maintaining a separate verifier
> for each exported filesystem in each net namespace.
> 
> 

Yeah, it's not pretty, but I think the alternative is worse. Most admins
would take rotten performance over data corruption.

For the most part, these sorts of errors tend to be rare. If it turns
out to be a problem we could consider moving the verifier into
svc_export or something?
-- 
Jeff Layton <jlayton@redhat.com>

